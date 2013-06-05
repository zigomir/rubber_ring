jasmine.getFixtures().fixturesPath = 'base/spec/javascripts/fixtures/';

var App = App || {};
App.controller        = "jasmine_test";
App.action            = "jasmine_test";
// Here you can use real values to see if they land into database, but tests will be slower then
//App.save_path         = "http://localhost:3000/rubber_ring/cms/save";
App.save_path          = "cms/save";
App.save_template_path = "cms/save_template";
App.remove_path        = "cms/remove/:key";

App.save_image_path      = "cms/save_image";
App.save_attachment_path = "cms/save_attachment";

App.add_attachment_path    = "cms/attachments/add";
App.remove_attachment_path = "cms/attachments/remove";

App.config = {
	action_btns: {
	  reset_btn: '<button class="reset-content"></button>',
    reset_img: '<button class="reset-image"></button>'
	}
};
