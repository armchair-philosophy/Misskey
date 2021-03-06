<mk-trends-home-widget>
	<p class="title"><i class="fa fa-fire"></i>%i18n:desktop.tags.mk-trends-home-widget.title%</p>
	<button onclick={ fetch } title="%i18n:desktop.tags.mk-trends-home-widget.refresh%"><i class="fa fa-refresh"></i></button>
	<div class="post" if={ !loading && post != null }>
		<p class="text"><a href="/{ post.user.username }/{ post.id }">{ post.text }</a></p>
		<p class="author">―<a href="/{ post.user.username }">@{ post.user.username }</a></p>
	</div>
	<p class="empty" if={ !loading && post == null }>%i18n:desktop.tags.mk-trends-home-widget.nothing%</p>
	<p class="loading" if={ loading }><i class="fa fa-spinner fa-pulse fa-fw"></i>%i18n:common.loading%<mk-ellipsis></mk-ellipsis></p>
	<style>
		:scope
			display block
			background #fff

			> .title
				margin 0
				padding 0 16px
				line-height 42px
				font-size 0.9em
				font-weight bold
				color #888
				border-bottom solid 1px #eee

				> i
					margin-right 4px

			> button
				position absolute
				z-index 2
				top 0
				right 0
				padding 0
				width 42px
				font-size 0.9em
				line-height 42px
				color #ccc

				&:hover
					color #aaa

				&:active
					color #999

			> .post
				padding 16px
				font-size 12px
				font-style oblique
				color #555

				> p
					margin 0

				> .text,
				> .author
					> a
						color inherit

			> .empty
				margin 0
				padding 16px
				text-align center
				color #aaa

			> .loading
				margin 0
				padding 16px
				text-align center
				color #aaa

				> i
					margin-right 4px

	</style>
	<script>
		this.mixin('api');

		this.post = null;
		this.loading = true;

		this.offset = 0;

		this.on('mount', () => {
			this.fetch();
		});

		this.fetch = () => {
			this.update({
				loading: true,
				post: null
			});
			this.api('posts/trend', {
				limit: 1,
				offset: this.offset,
				repost: false,
				reply: false,
				media: false,
				poll: false
			}).then(posts => {
				const post = posts ? posts[0] : null;
				if (post == null) {
					this.offset = 0;
				} else {
					this.offset++;
				}
				this.update({
					loading: false,
					post: post
				});
			});
		};
	</script>
</mk-trends-home-widget>
