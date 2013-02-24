(function($) {

  describe("ShortUrl", function() {
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

    describe("#onRedirect", function() {
      beforeEach(function() {
        this.test = new ShortUrl();
      });
      it("should be chainable", function() {
        expect( this.test.onRedirect() ).toEqual(this.test);
      });
    });

    describe("#onError", function() {
      beforeEach(function() {
        this.test = new ShortUrl();
      });
      it("should be chainable", function() {
        expect( this.test.onError() ).toEqual(this.test);
      });
    });

    describe("#onDisplay", function() {
      beforeEach(function() {
        this.test = new ShortUrl();
      });
      it("should be chainable", function() {
        expect( this.test.onDisplay() ).toEqual(this.test);
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
      it("should be chainable", function() {
        expect( this.test.setPath() ).toEqual(this.test);
      });
    });

    describe("#redirectTo (static)", function() {
      it("needs no test");
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
      describe("'redirect' event", function() {
        beforeEach(function() {
          this.event_callback = jasmine.createSpy("onRedirect");
          $(this.test).on("redirect", this.event_callback);
          this.test.loadLocation("test_id");
        });
        it("should trigger when id is found in data", function() {
          expect( this.event_callback ).toHaveBeenCalled();
        });
        describe("passed in event object", function() {
          beforeEach(function() {
            this.result = this.event_callback.mostRecentCall.args[0];
          });
          it("should have id property", function() {
            expect( this.result.id ).toBeDefined();
            expect( this.result.id ).toEqual(jasmine.any(String));
          });
          it("should have url property", function() {
            expect( this.result.url ).toBeDefined();
            expect( this.result.url ).toEqual(jasmine.any(String));
          });
          it("should have short_path property", function() {
            expect( this.result.short_path ).toBeDefined();
            expect( this.result.short_path ).toEqual(jasmine.any(String));
          });
        });
      });
      describe("'error' event", function() {
        beforeEach(function() {
          this.event_callback = jasmine.createSpy("onError");
          $(this.test).on("error", this.event_callback);
          this.test.loadLocation("test_bad_id");
        });
        it("should trigger when id is not found in data", function() {
          expect( this.event_callback ).toHaveBeenCalled();
        });
        describe("passed in event object", function() {
          beforeEach(function() {
            this.result = this.event_callback.mostRecentCall.args[0];
          });
          it("should have id property", function() {
            expect( this.result.id ).toBeDefined();
            expect( this.result.id ).toEqual(jasmine.any(String));
          });
        });
      });
    });

    describe("#buildOutputItem", function() {
      beforeEach(function() {
        this.test = new ShortUrl({
          json: "test_json",
          path: "test_path"
        });
        this.test_id = "test_id";
        this.test_url = "test_url";
      });
      it("should return an object", function() {
        expect( this.test.buildOutputItem(this.test_id, this.test_url) ).toEqual(jasmine.any(Object));
      });
      describe("return object", function() {
        beforeEach(function() {
          this.result = this.test.buildOutputItem(this.test_id, this.test_url);
        });
        it("should have 'id' property", function() {
          expect( this.result.id ).toBeDefined();
          expect( this.result.id ).toBe("test_id");
        });
        it("should have 'url' property", function() {
          expect( this.result.url ).toBeDefined();
          expect( this.result.url ).toBe("test_url");
        });
        it("should have 'short_url' property", function() {
          expect( this.result.short_path ).toBeDefined();
          expect( this.result.short_path ).toContain("test_path");
          expect( this.result.short_path ).toContain("#test_id");
        });  
      });
    });

    describe("#output", function() {
      beforeEach(function() {
        this.display_callback = jasmine.createSpy("display_callback");
        this.test = new ShortUrl();
        this.test.onDisplay(this.display_callback);
        this.test.data = {
          "test_id1": "test_url1",
          "test_id2": "test_url2",
          "test_id3": "test_url3",
          "test_id4": "test_url4"
        };
        this.test.output();
      });
      it("should trigger 'display' event", function() {
        expect( this.display_callback ).toHaveBeenCalled();
      });
      describe("passed in event object", function() {
        beforeEach(function() {
          this.result = this.display_callback.mostRecentCall.args[0];
        });
        it("should have 'items' property as an array", function() {
          expect( this.result.items ).toBeDefined();
          expect( this.result.items ).toEqual(jasmine.any(Array));
        });
        describe("'items' array", function() {
          it("should have 'id' property", function() {
            expect( this.result.items[0].id ).toBeDefined();
            expect( this.result.items[0].id ).toEqual(jasmine.any(String));
          });
          it("should have 'url' property", function() {
            expect( this.result.items[0].url ).toBeDefined();
            expect( this.result.items[0].url ).toEqual(jasmine.any(String));
          });
          it("should have 'short_path' property", function() {
            expect( this.result.items[0].short_path ).toBeDefined();
            expect( this.result.items[0].short_path ).toEqual(jasmine.any(String));
          });
        });
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
