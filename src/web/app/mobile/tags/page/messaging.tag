<mk-messaging-page>
	<mk-ui ref="ui">
		<mk-messaging ref="index"></mk-messaging>
	</mk-ui>
	<style>
		:scope
			display block
	</style>
	<script>
		import ui from '../../scripts/ui-event';

		this.mixin('page');

		this.on('mount', () => {
			document.title = 'Misskey | %i18n:mobile.tags.mk-messaging-page.message%';
			ui.trigger('title', '<i class="fa fa-comments-o"></i>%i18n:mobile.tags.mk-messaging-page.message%');

			this.refs.ui.refs.index.on('navigate-user', user => {
				this.page('/i/messaging/' + user.username);
			});
		});
	</script>
</mk-messaging-page>
