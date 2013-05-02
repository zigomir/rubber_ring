var App = App || {};
App.controller        = "";
App.action            = "";
App.save_path         = "";
App.remove_path       = "";

App.save_image_path      = "";
App.save_attachment_path = "";

App.add_attachment_path    = "";
App.remove_attachment_path = "";

config = {
	action_btns: {
	  reset_btn:            '<button class="reset-content"></button>',
	  duplicate_btn:        '<button class="duplicate-content"></button>',
	  remove_duplicate_btn: '<button class="remove-duplicat"></button>'
	},
	reset_btn_exclusions:   ".duplicable, [data-cms=page_title]"
};
