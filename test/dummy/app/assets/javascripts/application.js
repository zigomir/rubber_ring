// Don't require jquery here because it will clash with the on from RubberRing gem
//= require_tree .

$(function() {
  console.log('I can haz mah own jqueriez at version: ' + $.fn.jquery);
});
