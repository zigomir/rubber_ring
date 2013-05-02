describe "Duplicable field", ->

  beforeEach ->
    loadFixtures('editable_fields.html')

    $("body").unbind() # we need to unbind all click event handler or else test will generate more clicks than we want
    de = new DuplicableEditor(config.action_btns)
    de.init()

  it "should duplicate fields if user clicks on duplicate-content button", ->
    expect($("[data-cms-group=blog_posts]").length).toBe(1)
    expect($("[data-cms=blog_posts_0]")).toExist()

    $(".duplicable_holder li:first .duplicate-content").click()
    expect($("[data-cms-group=blog_posts]").length).toBe(2)
    expect($("[data-cms=blog_posts_1]")).toExist()

    $(".duplicable_holder li:first .duplicate-content").click()
    expect($("[data-cms-group=blog_posts]").length).toBe(3)
    expect($("[data-cms=blog_posts_2]")).toExist()
    expect($("[data-cms=blog_posts_3]")).not.toExist()

  it "should remove one of duplicates when user clicks on remove-duplicat button", ->
    expect($("[data-cms-group=blog_posts]").length).toBe(1)
    expect($("[data-cms=blog_posts_0]")).toExist()

    $(".duplicable_holder li:first .duplicate-content").click()
    expect($("[data-cms-group=blog_posts]").length).toBe(2)
    expect($("[data-cms=blog_posts_1]")).toExist()

    $(".duplicable_holder .remove-duplicat").click()
    expect($("[data-cms-group=blog_posts]").length).toBe(1)
    expect($("[data-cms=blog_posts_1]")).not.toExist()

  it "should add two action buttons to first duplicable field", ->
    expect($(".duplicable_holder li:first .reset-content")).toExist()
    expect($(".duplicable_holder li:first .duplicate-content")).toExist()
    expect($(".duplicable_holder li:first .remove-duplicat")).not.toExist()

  it "should add only remove button to non-first duplicable fields", ->
    $(".duplicable_holder li:first .duplicate-content").click()
    expect($(".duplicable_holder li:last .reset-content")).not.toExist()
    expect($(".duplicable_holder li:last .duplicate-content")).not.toExist()
    expect($(".duplicable_holder li:last .remove-duplicat")).toExist()

  it "should remove reset-content button after more duplicables were added", ->
    expect($(".duplicable_holder li:first .reset-content")).toExist()

    $(".duplicable_holder li:first .duplicate-content").click()
    expect($(".duplicable_holder li:first .reset-content")).not.toExist()