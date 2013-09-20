/**
 * @fileOverview FileManager class.
 * @author <a href="mailto:paul.cuthbertson@gamesys.co.uk">Paul Cuthbertson</a>
 * @copyright Gamesys Limited 2013
 */

var shine = shine || {};



/**
 * Handles loading packages and distilled scripts.
 * @constructor
 * @extends shine.EventEmitter
 */
shine.FileManager = function () {
	shine.EventEmitter.call(this);
	this._cache = {};
};


shine.FileManager.prototype = new shine.EventEmitter();
shine.FileManager.prototype.constructor = shine.FileManager;




/**
 * Loads a file or package.
 * @param {String|Object} url Url of distilled json file or luac byte code file, or the json or byte code itself, or an object tree.
 * @param {Function} callback Load successful callback.
 */
shine.FileManager.prototype.load = function (url, callback) {
	var me = this,
		data;


	function parse (data, url) {
		var tree;

		if (me.constructor._isJson(data)) {
			// JSON
			tree = JSON.parse(data);

		} else if (me.constructor._isLuac(data)) {
			// Raw Lua 5.1 byte code
			tree = me.constructor._parseLuac(data);
		}

		if (tree) {
			if (url) me._cache[url] = tree;
			me._onSuccess(url || '', tree, callback);
		}

		return !!tree;
	}


	function success (data) {
		if (!parse(data, url)) throw new Error('File contains non-parsable content: ' + url);
	}


	function error (code) {
		me._onError(code, callback);
	}


	switch (typeof url) {
		case 'string':

			if (!parse(url)) {
				// If not parseable, treat as filename
				if (data = this._cache[url]) {
					window.setTimeout(function () { me._onSuccess(url, data, callback); }, 1);
				} else {
					shine.utils.get(url, success, error);
				}
			}

			break;

	
		case 'object':
			this._onSuccess('', url, callback);


		default: 
			throw new TypeError('Can\'t load object of unknown type');
	}
};




/**
 * Handles a successful response from the server.
 * @param {String} data Response.
 */
shine.FileManager.prototype._onSuccess = function (url, data, callback) {
	var file, i;

	if (data.format == 'moonshine.package') {
		for (i in data.files) this._cache[i] = data.files[i];
		this._trigger('loaded-package', data);

		if (!(url = data.main)) return;
		if (!(data = data.files[url])) throw new ReferenceError("The package's main reference does not point to a filename within the package");
	}

	file = new shine.File(url, data);
	
	this._onFileLoaded(file, function () {
		callback(null, file);
	});
};




/**
 * Hook called when a distilled file is loaded successfully. Overridden by debug engine.
 * @param {String} data Response.
 */
shine.FileManager.prototype._onFileLoaded = function (file, callback) {
	callback();
};




/**
 * Handles an unsuccessful response from the server. Overridden by debug engine.
 * @param {Number} code HTTP resonse code.
 */
shine.FileManager.prototype._onError = function (code, callback) {
	callback(code);
};




/**
 * Checks if a value represents a JSON string.
 * @param {String} val String to be checked.
 * @returns {Boolean} Is a JSON string?
 */
shine.FileManager._isJson = function (val) {
	return /^({.*}|\[.*\])$/.test(val);
};




/**
 * Checks if a value represents a Lua 5.1 byte code.
 * @param {String} val String to be checked.
 * @returns {Boolean} Is byte code?
 */
shine.FileManager._isLuac = function (val) {
	return val.substr(0, 5) == String.fromCharCode(27, 76, 117, 97, 81);
};




/**
 * Parses a string containing valid Lua 5.1 byte code into a tree.
 * Note: Requires Moonshine Distillery and could return unexpected results if ArrayBuffer is not supported.
 * @param {String} data Byte code string.
 * @returns {Object} Tree repesenting the Lua script.
 * @throws {Error} If Moonshine's distillery is not available.
 */
shine.FileManager._parseLuac = function (data) {
	if (!shine.distillery) throw new Error('Moonshine needs the distillery to parse Lua byte code. Please include "distillery.moonshine.js" in the page.');
	if (!('ArrayBuffer' in window)) console.warn('Browser does not support ArrayBuffers, this could cause unexpected results when loading binary files.');
	return new shine.distillery.Parser().parse(data);
};




/**
 * Dump memory associated with FileManager.
 */
shine.FileManager.prototype.dispose = function () {
	delete this._cache;
};

