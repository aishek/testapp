(function( $ ) {

	/** @private */
	var Utils = {
		
		extractClassName: function(resource_name) {
			var class_name = resource_name,
					index = resource_name.lastIndexOf('/');

			if ( index > -1 ) {
				class_name = resource_name.substr(index + 1, resource_name.length);
			}

			return class_name;
		},
		
		createResourceURL: function(resource_name, id) {
			return resource_name + '/' + id;
		},
		
		singularize: function(class_name) {
			var singular_class_name = class_name;

			if ( class_name.substr(class_name.length - 2, class_name.length) == 'es' ) {
				singular_class_name = class_name.substr(0, class_name.length - 2);
			}
			else {
				if ( class_name.substr(class_name.length - 1, class_name.length) == 's' ) {
					singular_class_name = class_name.substr(0, class_name.length - 1);
				}
			}
			
			return singular_class_name;
		},
		
		prepareData: function(data, singular_class_name) {
			var new_data = {};
			for (var key in data) {
				new_data[singular_class_name + '[' + key + ']'] = data[key];
			}

			return new_data;
		}
		
	};

	/** @private */
	var Resource = {

		create: function(resource_name, data) {
			var prepared_data = data;

			if ( data ) {
				var class_name = Utils.extractClassName(resource_name);		
				var singular_class_name = Utils.singularize(class_name);
			
				prepared_data = Utils.prepareData(data, singular_class_name);
			}
		
			return $.ajax(
				{
					url: resource_name,
					data: prepared_data,
					dataType: 'script',
					async: true,
					type: 'post'
				}
			);
		},

		delete: function(resource_name, options) {
			var id = ( $.isPlainObject(options) ? options.id : options )
		
			return $.ajax(
				{
					url: Utils.createResourceURL(resource_name, id),
					async: true,
					dataType: 'script',
					type: 'delete'
				}
			);
		}
		
	};
		
  $.rr = {
	
		create: function(resource_name, options) {
			return Resource.create(resource_name, options);
		},
		
		delete: function(resource_name, options) {
			return Resource.delete(resource_name, options);
		}
	
	};
	
	/**
	* Wrapper for $.rr.create function.
	*
	* On click creates new resource's instance.
	*
	* If create fails, alerts errors, which app returns in json format
	*
	* @param {Stirng} resource_name the name of resource in plural form
	* @param {Object} data data to create an object
	*/
	$.fn.rr_create = function(resource_name, data) {
		this.each(
			function() {
				
				$(this).click(
					function() {
						var deffered = $.rr.create(resource_name, data);
						deffered.fail(
							function(request) {
								// request.responseText contains errors json
								eval('var errors = ' + request.responseText);

								var m = "Cannot create resource because of:\n";
								for(var key in errors) {
									m += "\t" + key + " - " + errors[key] + "\n";
								}
								alert(m);
							}
						);						
					}
				);
			}
		);
	};
	
	/**
	* Wrapper for $.rr.delete function.
	*
	* On click delete resource, which id should be provided in element's "id" or "resource_id" attribute's value,
	* and resource name should be provided in element's "resource" attribute's value or in "resource_name" key's value of options object in plural form
	*
	* If delete success, than it hides parent element
	*
	* @param {Object} options
	*/
	$.fn.rr_delete = function(options) {
		var settings = {
			hide: {
				parentSelector: function(target) { return $(target).parent(); },
				effect: function(parent) { parent.fadeOut(); }
			}
    };
		if ( options ) { 
			$.extend( settings, options );
    }		
		
		this.each(
			function() {
      	var resource_name = $(this).attr('resource') || settings.resource_name,
      			resource_id = $(this).attr('resource_id') || $(this).attr('id')
				
				if ( resource_name && resource_id ) {

					$(this).click(
						function() {
							var deffered = $.rr.delete(resource_name, resource_id);
						
							var that = this;
							deffered.success(
								function() {
									var parent = ( $.isFunction(settings.hide.parentSelector) ? settings.hide.parentSelector(that) : $(settings.hide.parentSelector, that) );
									settings.hide.effect(parent);
								}
							);						

							return false;
						}
					);
				}
				
			}
		);
		
	}

})( jQuery );