<mk-post-preview title={ title }>
	<article><a class="avatar-anchor" href={ '/' + post.user.username }><img class="avatar" src={ post.user.avatar_url + '?thumbnail&size=64' } alt="avatar" data-user-preview={ post.user_id }/></a>
		<div class="main">
			<header><a class="name" href={ '/' + post.user.username } data-user-preview={ post.user_id }>{ post.user.name }</a><span class="username">@{ post.user.username }</span><a class="time" href={ '/' + post.user.username + '/' + post.id }>
					<mk-time time={ post.created_at }></mk-time></a></header>
			<div class="body">
				<mk-sub-post-content class="text" post={ post }></mk-sub-post-content>
			</div>
		</div>
	</article>
	<style>
		:scope
			display block
			margin 0
			padding 0
			font-size 0.9em
			background #fff

			> article

				&:after
					content ""
					display block
					clear both

				&:hover
					> .main > footer > button
						color #888

				> .avatar-anchor
					display block
					float left
					margin 0 16px 0 0

					> .avatar
						display block
						width 52px
						height 52px
						margin 0
						border-radius 8px
						vertical-align bottom

				> .main
					float left
					width calc(100% - 68px)

					> header
						display flex
						margin 4px 0
						white-space nowrap

						> .name
							margin 0 .5em 0 0
							padding 0
							color #607073
							font-size 1em
							line-height 1.1em
							font-weight 700
							text-align left
							text-decoration none
							white-space normal

							&:hover
								text-decoration underline

						> .username
							text-align left
							margin 0 .5em 0 0
							color #d1d8da

						> .time
							margin-left auto
							color #b2b8bb

					> .body

						> .text
							cursor default
							margin 0
							padding 0
							font-size 1.1em
							color #717171

	</style>
	<script>
		import dateStringify from '../../common/scripts/date-stringify';

		this.mixin('user-preview');

		this.post = this.opts.post;

		this.title = dateStringify(this.post.created_at);
	</script>
</mk-post-preview>
