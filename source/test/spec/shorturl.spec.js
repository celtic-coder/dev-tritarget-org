(function($) {

  describe("ShortUrl Object", function() {
    var ShortUrl = require("ShortUrl");

    beforeEach(function() {
      this.test_loading_JSON = $.Deferred()
      spyOn($, "getJSON").andReturn(this.test_loading_JSON.promise());
      spyOn(ShortUrl, "redirectTo");
    });

    describe("#constructor", function() {
      var test_constructor = function() {
        it("should define @path", function() {
          expect( this.test.path ).toBeDefined();
          expect( this.test.path ).toEqual(jasmine.any(String));
        });
        it("should deffer when loading JSON", function() {
          expect( this.test._loading_JSON.state() ).toBe("pending");
        });
        it("should deffer when waiting for all done", function() {
          expect( this.test._waiting_for_all_done.state() ).toBe("pending");
        });
      };
      describe("invocation with path argument", function() {
        beforeEach(function() {
          this.test = new ShortUrl("foobar");
        });
        test_constructor();
        it("should deffer when waiting for ready", function() {
          expect( this.test._waiting_for_ready.state() ).toBe("pending");
        });
      });
      describe("invocation with path and options", function() {
        beforeEach(function() {
          this.test = new ShortUrl("foobar", {});
        });
        test_constructor();
        it("should not deffer when waiting for ready", function() {
          expect( this.test._waiting_for_ready.state() ).toBe("resolved");
        });
      });
      describe("invocation with only options", function() {
        beforeEach(function() {
          this.test = new ShortUrl({});
        });
        test_constructor();
        it("should not deffer when waiting for ready", function() {
          expect( this.test._waiting_for_ready.state() ).toBe("resolved");
        });
      });
    });

    describe("AJAX done", function() {
      beforeEach(function() {
        this.test = new ShortUrl("foobar");
        spyOn(this.test, "checkUrl");
      });
      it("should get JSON from path argument", function() {
        expect( $.getJSON ).toHaveBeenCalledWith("foobar");
      });
      it("should set the data", function() {
        this.test_loading_JSON.resolve("test_data");
        expect( this.test.data ).toBe("test_data");
      });
      it("should not call checkUrl when not ready", function() {
        this.test_loading_JSON.resolve("test_data");
        expect( this.test.checkUrl ).not.toHaveBeenCalled();
      });
      it("should call checkUrl when ready", function() {
        this.test._waiting_for_ready.resolve();
        this.test_loading_JSON.resolve("test_data");
        expect( this.test.checkUrl ).toHaveBeenCalled();
      });
    });

    describe("#setPath", function() {
      beforeEach(function() {
        this.test = new ShortUrl();
      });
      it("should provide a default", function() {
        this.test.setPath();
        expect( this.test.path ).toEqual(jasmine.any(String));
      });
      it("should accept one parameter", function() {
        this.test.setPath("foo");
        expect( this.test.path ).toBe("foo");
      });
      it("should accept two parameters", function() {
        this.test.setPath("foo", "bar");
        expect( this.test.path ).toContain("foo");
        expect( this.test.path ).toContain("bar");
      });
      it("should concate two parameters with a '/'", function() {
        this.test.setPath("foo", "bar");
        expect( this.test.path ).toBe("foo/bar");
        this.test.setPath("foo/", "bar");
        expect( this.test.path ).toBe("foo/bar");
        this.test.setPath("foo", "/bar");
        expect( this.test.path ).toBe("foo/bar");
        this.test.setPath("foo/", "/bar");
        expect( this.test.path ).toBe("foo/bar");
      });
    });

    describe("#setOutputWith", function() {
      beforeEach(function() {
        this.test = new ShortUrl();
      });
      it("should assign output_function", function() {
        var callback = jasmine.createSpy("output_function");
        this.test.setOutputWith(callback);
        expect( this.test.output_function ).toEqual(callback);
        expect( callback ).not.toHaveBeenCalled();
      });
    });

    describe("#redirectTo (static)", function() {
      it("needs no test");
    });

    describe("#outputData (static)", function() {
      beforeEach(function() {
        this.test = new ShortUrl({
          json: "test_json",
          path: "test_path"
        });
      });
      it("should add 'short_path' property to item", function() {
        var result = this.test.outputData({
          id: "test_id",
          url: "test_url"
        });
        expect( result.id ).toBeDefined();
        expect( result.url ).toBeDefined();
        expect( result.short_path ).toBeDefined();
        expect( result.short_path ).toContain("test_path");
        expect( result.short_path ).toContain("#test_id");
      });
    });

    describe("#loadLocation", function() {
      beforeEach(function() {
        jasmine.Clock.useMock();
        ShortUrl.redirectTo.reset();
        this.test = new ShortUrl();
        this.test.data = {"test_id":"test_url"};
      });
      it("should return true when id is found in data", function() {
        expect( this.test.loadLocation("test_id") ).toBeTruthy();
      });
      it("should redirect to proper url", function() {
        this.test.loadLocation("test_id");
        expect( ShortUrl.redirectTo ).not.toHaveBeenCalled();
        jasmine.Clock.tick(10);
        expect( ShortUrl.redirectTo ).toHaveBeenCalledWith("test_url");
      });
      it("should return false when id is not found in data", function() {
        expect( this.test.loadLocation("test_bad_id") ).toBeFalsy();
      });
      it("should trigger 'redirect' event when id is found in data", function() {
        var event_callback = jasmine.createSpy("onRedirect");
        $(this.test).on("redirect", event_callback);
        this.test.loadLocation("test_id");
        expect( event_callback ).toHaveBeenCalled();
      });
      it("should trigger 'error' when id is not found in data", function() {
        var event_callback = jasmine.createSpy("onError");
        $(this.test).on("error", event_callback);
        this.test.loadLocation("test_bad_id");
        expect( event_callback ).toHaveBeenCalled();
      });
    });

    describe("#output", function() {
      beforeEach(function() {
        this.test = new ShortUrl();
        this.test.data = {"test_id":"test_url"};
        this.output_callback = jasmine.createSpy("output_callback");
      });
      it("should noop when no output callback is defined", function() {
        var _this = this;
        expect( function(){ _this.test.output(); } ).not.toThrow();
      });
      it("should call the output callback for each item in @data", function() {
        this.test.setOutputWith(this.output_callback);
        this.test.output();
        expect( this.output_callback ).toHaveBeenCalledWith(jasmine.any(Object));
      });
    });

    describe("#checkUrl", function() {
      beforeEach(function() {
        jasmine.Clock.useMock();
        this.test = new ShortUrl();
        spyOn(ShortUrl, "getHash");
        spyOn(this.test, "loadLocation");
        spyOn(this.test, "output");
        this.resolve = function() {
          this.test_loading_JSON.resolve("test_data");
          this.test._waiting_for_ready.resolve();
        };
      });
      it("should return false when not ready", function() {
        expect( this.test.checkUrl() ).toBeFalsy();
      });
      it("should load location when hash has id", function() {
        this.resolve();
        ShortUrl.getHash.andReturn("#test_id");
        this.test.checkUrl();
        expect( this.test.output ).not.toHaveBeenCalled();
        expect( this.test.loadLocation ).toHaveBeenCalledWith("test_id");
      });
      it("should output when hash is null", function() {
        this.resolve();
        ShortUrl.getHash.andReturn("");
        this.test.checkUrl();
        expect( this.test.loadLocation ).not.toHaveBeenCalled();
        expect( this.test.output ).not.toHaveBeenCalled();
        jasmine.Clock.tick(10);
        expect( this.test.loadLocation ).not.toHaveBeenCalled();
        expect( this.test.output ).toHaveBeenCalled();
      });
    });

    describe("#ready", function() {
      beforeEach(function() {
        this.test = new ShortUrl("foobar");
        spyOn(this.test, "checkUrl");
      });
      it("should not call checkUrl when AJAX not done", function() {
        this.test._waiting_for_ready.resolve();
        expect( this.test.checkUrl ).not.toHaveBeenCalled();
      });
      it("should call checkUrl when AJAX done", function() {
        this.test_loading_JSON.resolve("test_data");
        this.test._waiting_for_ready.resolve();
        expect( this.test.checkUrl ).toHaveBeenCalled();
      });
    });
  });

})(jQuery);
