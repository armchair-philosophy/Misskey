<mk-signin-history>
	<div class="records" if={ history.length != 0 }>
		<div each={ history }>
			<mk-time time={ created_at }></mk-time>
			<header><i class="fa fa-check" if={ success }></i><i class="fa fa-times" if={ !success }></i><span class="ip">{ ip }</span></header>
			<pre><code>{ JSON.stringify(headers, null, '    ') }</code></pre>
		</div>
	</div>
	<style type="stylus">
		:scope
			display block

			> .records
				> div
					padding 16px 0 0 0
					border-bottom solid 1px #eee

					> header

						> i
							margin-right 8px

							&.fa-check
								color #0fda82

							&.fa-times
								color #ff3100

						> .ip
							display inline-block
							color #444
							background #f8f8f8

					> mk-time
						position absolute
						top 16px
						right 0
						color #777

					> pre
						overflow auto
						max-height 100px

						> code
							white-space pre-wrap
							word-break break-all
							color #4a535a

	</style>
	<script>
		@mixin \api
		@mixin \stream

		@history = []
		@fetching = true

		@on \mount ~>
			@api \i/signin_history
			.then (history) ~>
				@history = history
				@fetching = false
				@update!
			.catch (err) ~>
				console.error err

			@stream.on \signin @on-signin

		@on \unmount ~>
			@stream.off \signin @on-signin

		@on-signin = (signin) ~>
			@history.unshift signin
			@update!
	</script>
</mk-signin-history>