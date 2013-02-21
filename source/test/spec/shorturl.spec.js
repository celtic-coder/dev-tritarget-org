(function($) {

  describe("ShortUrl Object", function() {
    var ShortUrl = require("ShortUrl");

    beforeEach(function() {
      spyOn($, "getJSON");
      this.testObj = new ShortUrl();
    });

    describe("#constructor", function() {
      beforeEach(function() {
        spyOn(ShortUrl.prototype, "setPath");
        this.test = new ShortUrl();
      });
      it("should initialize @ready to false", function() {
        expect( this.test.isReady ).toBeFalsy();
      });
      it("should call setPath", function() {
        expect( ShortUrl.prototype.setPath ).toHaveBeenCalled();
      });
    });

    describe("#setPath", function() {
      it("should provide a default", function() {
        this.testObj.setPath();
        expect( this.testObj.short_path ).toEqual(jasmine.any(String));
      });
      it("should accept one parameter", function() {
        this.testObj.setPath("foo");
        expect( this.testObj.short_path ).toBe("foo");
      });
      it("should accept two parameters", function() {
        this.testObj.setPath("foo", "bar");
        expect( this.testObj.short_path ).toContain("foo");
        expect( this.testObj.short_path ).toContain("bar");
      });
      it("should concate two parameters with a '/'", function() {
        this.testObj.setPath("foo", "bar");
        expect( this.testObj.short_path ).toBe("foo/bar");
        this.testObj.setPath("foo/", "bar");
        expect( this.testObj.short_path ).toBe("foo/bar");
        this.testObj.setPath("foo", "/bar");
        expect( this.testObj.short_path ).toBe("foo/bar");
        this.testObj.setPath("foo/", "/bar");
        expect( this.testObj.short_path ).toBe("foo/bar");
      });
    });

    describe("#loadLocation", function() {
      beforeEach(function() {
        spyOn(ShortUrl, "redirectTo");
        jasmine.Clock.useMock();
      });
      it("should redirect to proper url", function() {
      });
      it("should return true when id is found in data", function() {
      });
      it("should return false when id is not found in data", function() {
      });
    });

    describe("#output", function() {
    });

    describe("#checkUrl", function() {
    });

    describe("#ready", function() {
    });
  });

})(jQuery);
