jasmine.getFixtures().fixturesPath = 'base/spec/javascripts/fixtures/';

var App = App || {};
App.controller        = "jasmine_test";
App.action            = "jasmine_test";
// Here you can use real values to see if they land into database, but tests will be slower then
//App.save_path         = "http://localhost:3000/rubber_ring/cms/save";
App.save_path          = "";
App.save_template_path = "";
App.remove_path        = "";

App.save_image_path      = "";
App.save_attachment_path = "";

App.add_attachment_path    = "";
App.remove_attachment_path = "";

config = {
	action_btns: {
	  reset_btn:            '<button class="reset-content"></button>'
	}
};
