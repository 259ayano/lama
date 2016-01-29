/* *
 * 
 * jQuery.fcs.js v1.0
 * 
 * MIT License.
 * (c) 2011, 2015 Kuh Jaeger, Inc.
 * 
 * */

(function ($)
{
	$.fn.fcs = function (selector) {
		try{
			var self = $(this);
			$(selector).each(function() {
				individual(this, $(this), selector);
			});
			return true;
		} catch(e){
			console.log(e.message);
			return false;
		}

		function individual(thisElem, thisSelf, thisSelector)
		{
			var elem = thisElem;    // DOM Object input
			var self = thisSelf;    // jQuery Object
			var selector = thisSelector;
			this.prevString = "";

			$.fn.getSelector = function () {
				return selector;
			};

			$.fn.setPreviousText = function (val) {
				this.prevString = val;
			};

			self.focus(function (e) {
				this.prevString = self.val();
			});

			self.keypress(function (e)
			{
				switch (e.keyCode) {
					case 13: //return
						this.prevString = self.val();
						return false;
				}
			});

			self.keydown(function (e) {
				if (e.keyCode === 13) {
					if (this.tagName.toUpperCase() === "TEXTAREA") {
						//if (e.shiftKey || e.ctrlKey || e.altKey) {
						if (e.altKey) {
							moveFocus(e);
						} else {
							var textareaElement = self.get(0);
							var position = textareaElement.selectionStart;

							var text = this.value;
							var length = this.length;

							var before = text.substring(0, position);
							var after = text.substring(position, length);

							var newText = before + "\n" + after;
							this.value = newText;
							this.prevString = newText;

							return true;
						}
					} else {
						if (!e.ctrlKey) {
							moveFocus(e);
							return false;
						}
					}
				}
			});

			function moveFocus(e) {
				if (e.shiftKey) {
					focusPrevious();
				} else {
					focusNext();
				}
			}

			function focusNext()
			{
				var fcs = $(selector + ":visible");
				var next = elem;
				var type = elem.type;
				var fineded = false;

				for (var i = 0; i < fcs.length; i++) {

					if (fcs[i].name === elem.name) {
						fineded = true;
					}
					if (!fineded) {
						continue;
					}

					if (i === fcs.length - 1)
					{
						next = fcs[0];
					} else {
						next = fcs[i + 1];
					}

					if (type === "checkbox" || type === "radio")
					{
						if (fcs[i].name !== elem.name || fcs[i].value === elem.value)
						{
							if (i === fcs.length - 1) {
								next = fcs[0];
							} else {
								next = fcs[i + 1];
							}
							break;
						}
					}
					else
					{
						if (fcs[i].name !== elem.name)
						{
							if (i === fcs.length) {
								next = fcs[0];
							} else {
								for (var j = i; j < fcs.length; j++)
								{
									if (fcs[j].disabled) {
										continue;
									}
									next = fcs[j];
									if (fcs[j].name !== elem.name) {
										break;
									}
								}
							}
							break;
						}
					}
				}
				focus(next);
			}

			function focusPrevious()
			{
				var fcs = $(selector + ":visible");
				var next = elem;
				var type = $("[name='" + next.name + "']").attr("type");
				var fineded = false;

				for (var i = 0; i < fcs.length; i++)
				{
					if (fcs[i].name === elem.name) {
						fineded = true;
					}
					if (!fineded) {
						continue;
					}
					if (i === 0)
					{
						next = fcs[fcs.length - 1];
					} else {
						next = fcs[i - 1];
					}

					if (type === "checkbox" || type === "radio")
					{
						if (fcs[i].name !== elem.name || fcs[i].value === elem.value) {
							if (i === 0)
							{
								next = fcs[fcs.length - 1];
							} else {
								next = fcs[i - 1];
							}
							break;
						}
					} else {
						if (fcs[i].name === elem.name) {
							if (i === 0) {
								next = fcs[fcs.length - 1];
							} else {
								for (var j = i; j >= 0; j--)
								{
									if (fcs[j].disabled) {
										continue;
									}
									next = fcs[j];
									if (fcs[j].name !== elem.name) {
										break;
									}
								}
							}
							break;
						}
					}
				}
				focus(next);
			}

			function focus(next)
			{
				next.focus();

				if (typeof next.select === "function") {
					var text = next.value;
					next.value = '';
					next.value = text;
				}
			}
		}
	};
})(jQuery);
