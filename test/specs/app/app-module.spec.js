define(['jquery'], function($) {
  describe("Spec example with fixtures", function() {

    it("should have a paragraph on sample HTML fixture", function() {
      loadFixtures('sample.html');

      expect($('p')).toHaveText(/ipsum dolor/);
    });

    it("should have a font size of 12px on a paragraph on sample HTML fixture", function() {
      loadFixtures('sample.html');
      loadStyleFixtures('sample.css');

      expect($('p')).toHaveCss({ "font-size" : "12px"});
    });

    it("should have 'sample' attribute on JSON fixture", function() {
      var data = getJSONFixture('sample.json');

      expect(data.sample).toBeDefined();
      expect(data.sample).toContain('ipsum dolor');
    });

  });
});