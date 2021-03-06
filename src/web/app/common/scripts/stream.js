'use strict';

const ReconnectingWebSocket = require('reconnecting-websocket');
import * as riot from 'riot';
import CONFIG from './config';

/**
 * Home stream connection
 */
class Connection {
	constructor(me) {
		// BIND -----------------------------------
		this.onOpen =    this.onOpen.bind(this);
		this.onClose =   this.onClose.bind(this);
		this.onMessage = this.onMessage.bind(this);
		this.send =      this.send.bind(this);
		this.close =     this.close.bind(this);
		// ----------------------------------------

		riot.observable(this);

		this.state = 'initializing';
		this.me = me;
		this.buffer = [];

		const host = CONFIG.apiUrl.replace('http', 'ws');
		this.socket = new ReconnectingWebSocket(`${host}?i=${me.token}`);
		this.socket.addEventListener('open', this.onOpen);
		this.socket.addEventListener('close', this.onClose);
		this.socket.addEventListener('message', this.onMessage);

		this.on('i_updated', me.update);
	}

	/**
	 * Callback of when open connection
	 * @private
	 */
	onOpen() {
		this.state = 'connected';
		this.trigger('_connected_');

		// バッファーを処理
		const _buffer = [].concat(this.buffer); // Shallow copy
		this.buffer = []; // Clear buffer
		_buffer.forEach(message => {
			this.send(message); // Resend each buffered messages
		});
	}

	/**
	 * Callback of when close connection
	 * @private
	 */
	onClose() {
		this.state = 'reconnecting';
		this.trigger('_closed_');
	}

	/**
	 * Callback of when received a message from connection
	 * @private
	 */
	onMessage(message) {
		try {
			const msg = JSON.parse(message.data);
			if (msg.type) this.trigger(msg.type, msg.body);
		} catch(e) {
			// noop
		}
	}

	/**
	 * Send a message to connection
	 * @public
	 */
	send(message) {
		// まだ接続が確立されていなかったらバッファリングして次に接続した時に送信する
		if (this.state != 'connected') {
			this.buffer.push(message);
			return;
		};

		this.socket.send(JSON.stringify(message));
	}

	/**
	 * Close this connection
	 * @public
	 */
	close() {
		this.socket.removeEventListener('open', this.onOpen);
		this.socket.removeEventListener('message', this.onMessage);
	}
}

export default Connection;
