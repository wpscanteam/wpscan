/*global jQuery, Loader, Skin*/
/*jslint browser: true */
(function() {
    'use strict';

    /**
     * The Qoob starter class 
     * Load all JS and CSS files
     *  
     * @version 0.0.1
     * @class  QoobStarter
     */

    function QoobStarter(options) {
        if (!(options.driver instanceof Object)) {
            throw new Error('Driver parameter mast be set!');
        }

        this.options = options;
        this.options.skip = options.skip || [];
        var pathname = window.location.pathname.replace(/\/.*\..*?$/g, '/');
        this.options.qoobUrl = this.options.qoobUrl || window.location.protocol + "//" + window.location.hostname + (window.location.port ? ':' + window.location.port : '') + pathname + (pathname.indexOf("/", pathname.length - "/".length) !== -1 ? '' : '/') + "qoob/";
        this.options.qoobUrl = this.options.qoobUrl + (this.options.qoobUrl.indexOf("/", this.options.qoobUrl.length - "/".length) !== -1 ? '' : '/');
        this.options.debug = this.options.debug || false;
        this.options.mode = this.options.mode || "prod";
        this.options.skin = this.options.skin || "simple";
        this.options.skinUrl = this.options.skinUrl || this.options.qoobUrl + 'skins/'+this.options.skin+'/';
        this.options.librariesData = this.options.librariesData || [];
        this.options.pageData = this.options.pageData || {};
        this.options.translations = this.options.translations || null;

        window.onload = this.startStage1.bind(this);
    }

    QoobStarter.prototype.loadingProgress = function(queue, loading, loaded, failed) {
        var countStages = 7;
        var deltaPerStage = 100 / countStages;
        var stageLoaded = this.loader.getCountLoaded() - this.loader.stageLoaded;
        var total = queue + loading + failed + stageLoaded;
        var stageProgress = (failed + stageLoaded) * 100 / total;
        var progress = parseInt((this.loader.stage - 1) * deltaPerStage + (deltaPerStage / 100 * stageProgress));
        document.getElementById("qoob_loader_precent").innerHTML = progress;
        if (progress == 100) {
            this.loadingComplete();
        }
    };

    QoobStarter.prototype.loadingComplete = function() {
        if (document.getElementById("qoob_loader_precent") !== null) {
            document.getElementById("qoob_loader_precent").innerHTML = 100;
            this.loader.off('progress', this.loadingProgressListener);
            jQuery('#loader-wrapper').delay(100).fadeOut(1000, function() {
                jQuery('#loader-wrapper').remove();
            });
        }
    };

    QoobStarter.prototype.startStage1 = function() {
        var self = this;
        var script = document.createElement('script');
        script.setAttribute('type', 'text/javascript');
        script.setAttribute('src', this.options.qoobUrl + "loader.min.js");
        script.onload = function() {

            self.loader = new Loader();
            self.loader.stage = 1;
            self.loader.stageLoaded = 0;
            self.options.loader = self.loader;
            self.attachLoaderHTML();
            self.loadingProgressListener = self.loadingProgress.bind(self);
            self.options.loader.on('progress', self.loadingProgressListener);
            for (var i = 0; i < self.options.skip.length; i++) {
                self.loader.loaded[self.options.skip[i]] = 1;
            }
            self.loader.add([
                { "type": "js", "name": "jquery", "src": self.options.qoobUrl + "libs/jquery.min.js" },
                { "type": "js", "name": "underscore", "src": self.options.qoobUrl + "libs/underscore.min.js", "dep": ["jquery"] },
                { "type": "js", "name": "backbone", "src": self.options.qoobUrl + "libs/backbone-min.js", "dep": ["jquery", "underscore"] },
                { "type": "js", "name": "handlebars", "src": self.options.qoobUrl + "libs/handlebars.min-latest.js" },
                { "type": "js", "name": "handlebars-helper", "src": self.options.qoobUrl + "libs/handlebars-helper.js", "dep": ["handlebars"] }
            ]);

            self.loader.once('complete', self.startStage2.bind(self));
            self.loader.start();
        };
        script.onerror = function() {
            console.error("Can't load loader.js file");
        };
        document.head.appendChild(script);

    };

    QoobStarter.prototype.startStage2 = function() {
        var self = this;
        self.loader.stage = 2;
        self.loader.stageLoaded = self.loader.getCountLoaded();

        this.options.driver.loadLibrariesData(function(err, libs) {

            if (err) {
                console.error("Libraries have been not loaded from driver " + self.options.driver.constructor.name + "." + err);
                return;
            }
            if (typeof(libs) == 'undefined') {
                console.error("Libraries have been not loaded from driver " + self.options.driver.constructor.name + ". Check 'loadLibrariesData' method.");
                return;
            }

            for (var i = 0; i < libs.length; i++) {
                var libUrl = libs[i].url.replace(/\/+$/g, '') + "/"; //Trim slashes in the end and add /

                if (libs[i].res) {
                    var res = libs[i].res;
                    for (var j = 0; j < res.length; j++) {
                        if (res[j].backend && res[j].backend === true) {
                            if (res[j].src.indexOf("http://") !== 0 && res[j].src.indexOf("https://") !== 0) {
                                res[j].src = libUrl + res[j].src.replace(/^\/+/g, ''); //Trim slashes in the begining
                            }

                            self.loader.add(res[j]);
                        }
                    }
                }

                var blocks = libs[i].blocks;

                if (undefined !== blocks) {
                    for (var k = 0; k < blocks.length; k++) {
                        if (undefined !== blocks[k]) {
                            blocks[k].url = blocks[k].url.replace(/\/+$/g, '') + "/"; //Trim slashes in the end and add /

                            if (blocks[k].url.indexOf("http://") !== 0 && blocks[k].url.indexOf("https://") !== 0) {
                                blocks[k].url = libUrl + blocks[k].url;
                            }
                            if (blocks[k].config_url) {
                                if (blocks[k].config_url.indexOf("http://") !== 0 && blocks[k].config_url.indexOf("https://") !== 0) {
                                    blocks[k].config_url = libUrl + blocks[k].config_url.replace(/^\/+/g, ''); //Trim slashes in the begining
                                }
                            } else {
                                blocks[k].config_url = blocks[k].url + "config.json";
                            }

                            self.loader.add({ "type": "json", "name": libs[i].name + "_" + blocks[k].name, "src": blocks[k].config_url });
                        }
                    }
                }
            }

            self.loader.once('complete', function() {
                self.options.librariesData = self.parseBlockData(libs);
                self.startStage3();

            });
        });
    };

    QoobStarter.prototype.startStage3 = function() {
        var self = this;
        self.loader.stage = 3;
        self.loader.stageLoaded = self.loader.getCountLoaded();
        self.options.driver.loadPageData(function(err, data) {
            self.options.pageData = data;

            self.startStage4();

        });
    };

    QoobStarter.prototype.startStage4 = function() {
        var self = this;

        self.loader.stage = 4;
        self.loader.stageLoaded = self.loader.getCountLoaded();

        if (self.options.driver.translationsUrl !== undefined) {
            self.options.driver.loadTranslations(function(err, data) {
                self.options.translations = data;
                self.startStage5();
            });
        } else {
            self.startStage5();
        }
    };

    QoobStarter.prototype.startStage5 = function() {
        var self = this;
        self.loader.stage = 5;
        self.loader.stageLoaded = self.loader.getCountLoaded();
        self.loader.once('complete', function() {
            window.qoob = new Skin();
            self.loader.stage = 6;
            self.loader.stageLoaded = self.loader.getCountLoaded();

            self.loader.once('complete', function() {
                self.loader.stage = 7;
                self.loader.stageLoaded = self.loader.getCountLoaded();
                self.loader.once('skin_loaded', function() {
                    self.loadingComplete();
                });
                window.qoob.activate(self.options);
            });

            self.loader.add(window.qoob.assets[self.options.mode], { "prefix": self.options.skinUrl });
            self.loader.add(window.qoob.assets.all, { "prefix": self.options.skinUrl });
        });

        self.loader.add({ "type": "js", "src": self.options.skinUrl+'skin.js', "name": "skin" });
        if (self.options.driver.assets) {
            self.loader.add(self.options.driver.assets);
        }
    };

    QoobStarter.prototype.applyGlobalMask = function(libs) {
        var filterLibUrlFunction = function(substr) {
            var libName = substr.replace(/%lib_url\(|\)%\/|%lib_url\(|\)%/g, '').trim();
            var findedLib = _.findWhere(libs, { name: libName.trim() });
            if (findedLib) {
                return findedLib.url;
            }
        };
        var filterBlockUrlFunction = function(substr) {
            var blockLib = substr.replace(/%block_url\(|\)%\/|%block_url\(|\)%/g, '');
            var splited = blockLib.split(',');
            var libName, blockName, findedLib, findedBlock;
            if (splited.length === 2) {
                libName = splited[0];
                blockName = splited[1];
            } else if (splited.length === 1) {
                libName = currentLib.name;
                blockName = splited[0];
            } else {
                return substr;
            }

            findedLib = _.findWhere(libs, { name: libName.trim() });

            if (findedLib) {
                findedBlock = _.findWhere(findedLib.blocks, { name: blockName });
                if (findedBlock) {
                    return findedBlock.url;
                } else {
                    console.error("Can't apply mask '" + substr + "' for block '" + currentLib.blocks[j].name + "' in lib '" + currentLib.name + "'. Block '" + blockName + "' not found in '" + libName + "'.");
                    return substr;
                }
            }
        };
        for (var i = 0; i < libs.length; i++) {
            var currentLib = libs[i];
            if (undefined !== currentLib.blocks) {
                for (var j = 0; j < currentLib.blocks.length; j++) {
                    if (undefined !== libs[i].blocks[j]) {
                        var configString = JSON.stringify(libs[i].blocks[j].config);
                        configString = configString.replace(/%lib_url\(.*?\)%\/|%lib_url\(.*?\)%/g, filterLibUrlFunction);
                        configString = configString.replace(/%block_url\(.*?\)%\/|%block_url\(.*?\)%/g, filterBlockUrlFunction);
                        currentLib.blocks[j] = _.extend(JSON.parse(configString), currentLib.blocks[j]);
                    }
                }
            }
        }
        return libs;
    };

    QoobStarter.prototype.applySelfMask = function(config, libUrl, blockUrl) {

        var configString = JSON.stringify(config);

        configString = configString.replace(/%lib_url%\/|%lib_url%/g, function(substr) {
            return libUrl;
        });

        configString = configString.replace(/%block_url%\/|%block_url%/g, function(substr) {
            return blockUrl;
        });

        return JSON.parse(configString);
    };


    QoobStarter.prototype.parseBlockData = function(libs) {
        var result = [];

        for (var i = 0; i < libs.length; i++) {
            var lib = libs[i];

            if (undefined !== lib.blocks) {
                for (var j = 0; j < lib.blocks.length; j++) {
                    if (this.loader.loaded[lib.name + "_" + lib.blocks[j].name]) {
                        lib.blocks[j].lib = lib.name;
                        lib.blocks[j].config = this.applySelfMask(this.loader.loaded[lib.name + "_" + lib.blocks[j].name].data, lib.url, lib.blocks[j].url);
                    } else {
                        delete lib.blocks[j];
                    }
                }
            }
            result.push(lib);
        }

        return this.applyGlobalMask(result);
    };

    QoobStarter.prototype.getLoaderHTML = function() {
        return "<div id='loader-wrapper' style=' font-size: 20px; font-weight: 700; font-family: robotobold, sans-serif; position: relative; line-height: 1;  z-index: 9999; height: 100vh; background-color: #fff; display: flex; align-items: center; justify-content: center;'>" +
                    "<div class='loading-panel' style='text-align: center;  letter-spacing: 0.05em; color: #010833; -webkit-transition: -webkit-transform .5s ease 0s; -moz-transition: -moz-transform .5s ease 0s; -o-transition: -o-transform .5s ease 0s; transition: transform .5s ease 0s;  width: 100%;'>" +
                    "<span>Loading <span id='qoob_loader_precent'>0</span>%</span>" +
                    "<div class='loading-dots' style='margin: 19px auto 0 auto;'>" +
                        "<div class='loading-dot' style='width: 18px; height: 18px; margin-right: 7px; background-color: #010833; border-radius: 100%; display: inline-block; -webkit-animation: block-elements 1.4s ease-in-out 0s infinite both; animation: block-elements 1.4s ease-in-out 0s infinite both; -webkit-animation-delay: -.32s; animation-delay: -.32s;'></div>" +
                        "<div class='loading-dot' style='width: 18px; height: 18px; margin-right: 7px; background-color: #010833; border-radius: 100%; display: inline-block; -webkit-animation: block-elements 1.4s ease-in-out 0s infinite both; animation: block-elements 1.4s ease-in-out 0s infinite both; -webkit-animation-delay: -.16s; animation-delay: -.16s;'></div>" +
                        "<div class='loading-dot' style='width: 18px; height: 18px; margin-right: 7px; background-color: #010833; border-radius: 100%; display: inline-block; -webkit-animation: block-elements 1.4s ease-in-out 0s infinite both; animation: block-elements 1.4s ease-in-out 0s infinite both; margin-right: 0;'></div>" +
                    "</div>" +
                    "</div>" +
                    "<style>"+         
                        "html {"+
                            "-webkit-box-sizing: border-box;"+
                            "box-sizing: border-box;"+
                        "}"+
                        "*,"+
                        "*:before,"+
                        "*:after {"+
                            "-webkit-box-sizing: inherit;"+
                            "box-sizing: inherit;"+
                        "}"+
                        "body {"+
                            "margin:0; overflow: hidden; line-height: 1;"+
                        "}"+
                        "@-webkit-keyframes block-elements {"+
                            "0%,100%,80%{"+
                                "-webkit-transform:scale(0);"+
                                "transform:scale(0)"+
                            "}"+
                            "40%{"+
                                "-webkit-transform:scale(1);"+
                                "transform:scale(1)"+
                            "}"+
                        "}"+
                        "@keyframes block-elements {"+
                            "0%,100%,80%{"+
                                "-webkit-transform:scale(0);"+
                                "transform:scale(0)"+
                            "}"+
                            "40%{"+
                                "-webkit-transform:scale(1);"+
                                "transform:scale(1)"+
                            "}"+
                        "}   "+
                    "</style>"+
               "</div>";
    };


    QoobStarter.prototype.attachLoaderHTML = function() {
        document.body.innerHTML = this.getLoaderHTML() + document.body.innerHTML;
    };

    window.QoobStarter = QoobStarter;
    window.QoobVersion = "3.0.0";
}());
