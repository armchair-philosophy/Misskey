<mk-drive-file onclick={ onclick } data-is-selected={ isSelected }>
	<div class="container">
		<div class="thumbnail" style={ 'background-image: url(' + file.url + '?thumbnail&size=128)' }></div>
		<div class="body">
			<p class="name">{ file.name }</p>
			<!--
			if file.tags.length > 0
				ul.tags
					each tag in file.tags
						li.tag(style={background: tag.color, color: contrast(tag.color)})= tag.name
			-->
			<footer>
				<p class="type"><mk-file-type-icon type={ file.type }></mk-file-type-icon>{ file.type }</p>
				<p class="separator"></p>
				<p class="data-size">{ bytesToSize(file.datasize) }</p>
				<p class="separator"></p>
				<p class="created-at">
					<i class="fa fa-clock-o"></i><mk-time time={ file.created_at }></mk-time>
				</p>
			</footer>
		</div>
	</div>
	<style>
		:scope
			display block

			&, *
				user-select none

			*
				pointer-events none

			> .container
				max-width 500px
				margin 0 auto
				padding 16px

				&:after
					content ""
					display block
					clear both

				> .thumbnail
					display block
					float left
					width 64px
					height 64px
					background-size cover
					background-position center center

				> .body
					display block
					float left
					width calc(100% - 74px)
					margin-left 10px

					> .name
						display block
						margin 0
						padding 0
						font-size 0.9em
						font-weight bold
						color #555
						text-overflow ellipsis
						overflow-wrap break-word

					> .tags
						display block
						margin 4px 0 0 0
						padding 0
						list-style none
						font-size 0.5em

						> .tag
							display inline-block
							margin 0 5px 0 0
							padding 1px 5px
							border-radius 2px

					> footer
						display block
						margin 4px 0 0 0
						font-size 0.7em

						> .separator
							display inline
							margin 0
							padding 0 4px
							color #CDCDCD

						> .type
							display inline
							margin 0
							padding 0
							color #9D9D9D

							> mk-file-type-icon
								margin-right 4px

						> .data-size
							display inline
							margin 0
							padding 0
							color #9D9D9D

						> .created-at
							display inline
							margin 0
							padding 0
							color #BDBDBD

							> i
								margin-right 2px

			&[data-is-selected]
				background $theme-color

				&, *
					color #fff !important

	</style>
	<script>
		import bytesToSize from '../../../common/scripts/bytes-to-size';
		this.bytesToSize = bytesToSize;

		this.browser = this.parent;
		this.file = this.opts.file;
		this.isSelected = this.browser.selectedFiles.some(f => f.id == this.file.id);

		this.browser.on('change-selection', selections => {
			this.isSelected = selections.some(f => f.id == this.file.id);
		});

		this.onclick = () => {
			this.browser.chooseFile(this.file);
		};
	</script>
</mk-drive-file>
