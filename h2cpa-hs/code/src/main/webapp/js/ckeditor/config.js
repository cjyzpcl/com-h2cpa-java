/**
 * @license Copyright (c) 2003-2013, CKSource - Frederico Knabben. All rights
 *          reserved. For licensing, see LICENSE.md or
 *          http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function(config) {
	// Define changes to default configuration here. For example:
	config.language = 'zh-cn';
	config.height = '300px';
	config.filebrowserBrowseUrl = 'ckfinder/ckfinder.html';
	config.filebrowserImageBrowseUrl = 'ckfinder/ckfinder.html?type=Images';
	config.filebrowserFlashBrowseUrl = 'ckfinder/ckfinder.html?type=Flash';
	config.filebrowserUploadUrl = 'ckfinder/core/connector/java/connector.java?command=QuickUpload&type=Files';
	config.filebrowserImageUploadUrl = 'ckfinder/core/connector/java/connector.java?command=QuickUpload&type=Images';
	config.filebrowserFlashUploadUrl = 'ckfinder/core/connector/java/connector.java?command=QuickUpload&type=Flash';
	config.toolbar = [
	{
		name : 'tools',
		items : [ 'Maximize', 'ShowBlocks' ]
	},
	{
		name : 'document',
		items : [ 'Source', 'Preview', 'Templates' ]
	},
	{
		name : 'basicstyles',
		items : [ 'Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', '-', 'RemoveFormat' ]
	}, '/', {
		name : 'paragraph',
		items : [ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote', 'CreateDiv', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', '-', 'BidiLtr', 'BidiRtl' ]
	}, '/', {
		name : 'clipboard',
		items : [ 'Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord', '-', 'Undo', 'Redo' ]
	}, {
		name : 'editing',
		items : [ 'Find', 'Replace', '-', 'SelectAll', '-', 'SpellChecker' ]
	}, {
		name : 'links',
		items : [ 'Link', 'Unlink', 'Anchor' ]
	}, '/', {
		name : 'styles',
		items : [ 'Styles', 'Format', 'Font', 'FontSize' ]
	}, {
		name : 'colors',
		items : [ 'TextColor', 'BGColor' ]
	}, {
		name : 'insert',
		items : [ 'Image', 'Flash', 'Table', 'HorizontalRule', 'Smiley', 'SpecialChar' ]
	} ];
};
