/**
 * Module dependencies
 */
import $ from 'cafy';
import Post from '../../models/post';
import User from '../../models/user';
import serialize from '../../serializers/post';

/**
 * Get posts of a user
 *
 * @param {any} params
 * @param {any} me
 * @return {Promise<any>}
 */
module.exports = (params, me) => new Promise(async (res, rej) => {
	// Get 'user_id' parameter
	const [userId, userIdErr] = $(params.user_id).optional.id().$;
	if (userIdErr) return rej('invalid user_id param');

	// Get 'username' parameter
	const [username, usernameErr] = $(params.username).optional.string().$;
	if (usernameErr) return rej('invalid username param');

	if (userId === undefined && username === undefined) {
		return rej('user_id or username is required');
	}

	// Get 'include_replies' parameter
	const [includeReplies = true, includeRepliesErr] = $(params.include_replies).optional.boolean().$;
	if (includeRepliesErr) return rej('invalid include_replies param');

	// Get 'with_media' parameter
	const [withMedia = false, withMediaErr] = $(params.with_media).optional.boolean().$;
	if (withMediaErr) return rej('invalid with_media param');

	// Get 'limit' parameter
	const [limit = 10, limitErr] = $(params.limit).optional.number().range(1, 100).$;
	if (limitErr) return rej('invalid limit param');

	// Get 'since_id' parameter
	const [sinceId, sinceIdErr] = $(params.since_id).optional.id().$;
	if (sinceIdErr) return rej('invalid since_id param');

	// Get 'max_id' parameter
	const [maxId, maxIdErr] = $(params.max_id).optional.id().$;
	if (maxIdErr) return rej('invalid max_id param');

	// Check if both of since_id and max_id is specified
	if (sinceId && maxId) {
		return rej('cannot set since_id and max_id');
	}

	const q = userId !== undefined
		? { _id: userId }
		: { username_lower: username.toLowerCase() } ;

	// Lookup user
	const user = await User.findOne(q, {
		fields: {
			_id: true
		}
	});

	if (user === null) {
		return rej('user not found');
	}

	// Construct query
	const sort = {
		_id: -1
	};
	const query = {
		user_id: user._id
	} as any;
	if (sinceId) {
		sort._id = 1;
		query._id = {
			$gt: sinceId
		};
	} else if (maxId) {
		query._id = {
			$lt: maxId
		};
	}

	if (!includeReplies) {
		query.reply_to_id = null;
	}

	if (withMedia) {
		query.media_ids = {
			$exists: true,
			$ne: null
		};
	}

	// Issue query
	const posts = await Post
		.find(query, {
			limit: limit,
			sort: sort
		});

	// Serialize
	res(await Promise.all(posts.map(async (post) =>
		await serialize(post, me)
	)));
});
