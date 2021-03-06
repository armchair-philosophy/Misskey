<mk-ui-header>
	<mk-special-message></mk-special-message>
	<div class="main">
		<div class="backdrop"></div>
		<div class="content">
			<button class="nav" onclick={ parent.toggleDrawer }><i class="fa fa-bars"></i></button>
			<h1 ref="title">Misskey</h1>
			<button if={ func } onclick={ func }><i class="fa fa-{ funcIcon }"></i></button>
		</div>
	</div>
	<style>
		:scope
			$height = 48px

			display block
			position fixed
			top 0
			z-index 1024
			width 100%
			box-shadow 0 1px 0 rgba(#000, 0.075)

			> .main
				color rgba(#fff, 0.9)

				> .backdrop
					position absolute
					top 0
					z-index 1023
					width 100%
					height $height
					-webkit-backdrop-filter blur(12px)
					backdrop-filter blur(12px)
					background-color rgba(#1b2023, 0.75)

				> .content
					z-index 1024

					> h1
						display block
						margin 0 auto
						padding 0
						width 100%
						max-width calc(100% - 112px)
						text-align center
						font-size 1.1em
						font-weight normal
						line-height $height
						white-space nowrap
						overflow hidden
						text-overflow ellipsis

						> i
						> .icon
							margin-right 8px

						> img
							display inline-block
							vertical-align bottom
							width ($height - 16px)
							height ($height - 16px)
							margin 8px
							border-radius 6px

					> .nav
						display block
						position absolute
						top 0
						left 0
						width $height
						font-size 1.4em
						line-height $height
						border-right solid 1px rgba(#000, 0.1)

						> i
							transition all 0.2s ease

					> button:last-child
						display block
						position absolute
						top 0
						right 0
						width $height
						text-align center
						font-size 1.4em
						color inherit
						line-height $height
						border-left solid 1px rgba(#000, 0.1)

	</style>
	<script>
		import ui from '../scripts/ui-event';

		this.func = null;
		this.funcIcon = null;

		this.on('unmount', () => {
			ui.off('title', this.setTitle);
			ui.off('func', this.setFunc);
		});

		this.setTitle = title => {
			this.refs.title.innerHTML = title;
		};

		this.setFunc = (fn, icon) => {
			this.update({
				func: fn,
				funcIcon: icon
			});
		};

		ui.on('title', this.setTitle);
		ui.on('func', this.setFunc);
	</script>
</mk-ui-header>
