<mk-search-page>
	<mk-ui ref="ui">
		<mk-search ref="search" query={ parent.opts.query }></mk-search>
	</mk-ui>
	<style>
		:scope
			display block
	</style>
	<script>
		import ui from '../../scripts/ui-event';
		import Progress from '../../../common/scripts/loading';

		this.on('mount', () => {
			document.title = `%i18n:mobile.tags.mk-search-page.search%: ${this.opts.query} | Misskey`
			// TODO: クエリをHTMLエスケープ
			ui.trigger('title', '<i class="fa fa-search"></i>' + this.opts.query);

			Progress.start();

			this.refs.ui.refs.search.on('loaded', () => {
				Progress.done();
			});
		});
	</script>
</mk-search-page>
