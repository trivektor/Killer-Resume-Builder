var Krb = {
	
	init : function() {
		this.setup_selectors();
		this.setup_overlay_trigger();
		this.setup_overlay_close();
		this.setup_delete_action();
	},
	
	setup_selectors : function() {
		Krb.overlay = $("#overlay");
		Krb.trigger_overlay = $(".trigger_overlay");
		Krb.close_overlay = $(".close_overlay");
		Krb.delete_action = $(".delete");
	},
	
	setup_delete_action : function() {
		Krb.delete_action.bind("click", function(event) {
			event.preventDefault();
			if (confirm('Are you sure you want to delete this resume? This action cannot be undone')) {
				window.location.href = $(this).attr("href");
			}
		})
	},
	
	setup_scrolling : function(triggerer, triggering_action, scrollTo, speed) {
		triggerer.bind(triggering_action, function(){
			$.scrollTo(scrollTo, speed)
		})
	},
	
	setup_overlay_trigger : function() {
		Krb.trigger_overlay.bind("click", function() {
			$("#" + $(this).attr("rel")).show($(this).attr("effect"), {}, 100, function(){});
			Krb.overlay.show();
		})
	},
	
 	setup_overlay_close : function() {
		Krb.close_overlay.bind("click", function() {
			$(this).parent().fadeOut(function() {
				Krb.overlay.fadeOut();
			})
		})
	}
	
}

var MarkItUp = {
	
	init : function() {
		if ($(".markitup").length) {
			$(".markitup").markItUp(mySettings);
		}
	}
	
}

var Resume = {

	init : function() {
		var resume_id = $("#ResumeId");
		Resume.id = resume_id.val();
		
		this.setup_selectors();
		this.update_resume_settings();
		this.setup_editable_section_name();
		this.setup_section_options();
		
		this.setup_disable_section_action();
		this.setup_enable_section_action();
	},
	
	setup_selectors : function() {
		this.updated_status = $("#updated_status");
		this.update_resume_settings_btn = $("#update_resume_settings");
		this.editable_section_name = $(".section_name_editable");
		this.section_name_editor = $("input.section_name_editor");
		this.update_section_name = $("span.update_section_name");
		this.cancel_update_section_name = $("span.cancel_update_section_name");
		this.section_options = $(".section_options");
		Resume.disable_section = $(".disable_section");
		Resume.enable_section = $(".enable_section");
	},
	
	edit_section_name_action : function() {
		this.editable_section_name.bind('click', function() {
			$(this).hide().siblings().show();
		})
	},
	
	section_name_editor_keypress_action : function() {
		this.section_name_editor.bind('keypress', function(event){ 
			var key = event.keyCode ? event.keyCode : event.keyWhich;

			if (key == 13) {
				event.preventDefault();
				$(this).siblings("span.update_section_name").trigger('click')
			}

		})
	},
	
	update_section_name_action : function() {
		this.update_section_name.bind('click', function(){

			var t = $(this);

			var updatedName = t.siblings("input[type=text]").val();

			if (updatedName == '') {
				alert('Please enter a new name for this section');
				return;
			}

			$.ajax({
				type: "PUT",
				url: "/resumes/" + Resume.id + "/resume_section_names/" + $(this).siblings(".resume_section_name_id").val() ,
				data: {
					resume_section_name: {
						section:t.attr("rel"), 
						name:updatedName
					}
				},
				success: function(response){
					if (response.success == 1) {
						t.siblings(".section_name_editable").text(updatedName)
						t.siblings(".cancel_update_section_name").trigger("click");
						Resume.blinkUpdatedStatus();
					}
				}
			})
		})
	},
	
	cancel_update_section_name_action : function() {
		this.cancel_update_section_name.bind('click', function(){
			var _this = $(this);
			_this.hide();
			_this.siblings().hide().siblings("h2").show();
		})
	},
	
	setup_editable_section_name : function() {
		
		this.edit_section_name_action();
		
		this.section_name_editor_keypress_action();

		this.update_section_name_action();

		this.cancel_update_section_name_action();
		
	},
	
	setup_section_options : function() {
		this.section_options.hover(this.section_options_hover_in, this.section_options_hover_out)
	},
	
	section_options_hover_in : function() {
		$(this).children("div.options_label").hide();
		$(this).children("div.add").show();
		var sectionMode = $(this).children("input.section_mode").val();
		if (sectionMode == 'active') {
			$(this).children("a.disable_section").show();
			$(this).children("a.enable_section").hide();
		} else {
			$(this).children("a.enable_section").show();
			$(this).children("a.disable_section").hide();
		}
	},
	
	section_options_hover_out : function() {
		$(this).children().hide();
		$(this).children("div.options_label").show();
	},
	
	setup_disable_section_action : function() {
		Resume.disable_section.bind('click', function() {
			var t = $(this);
			$.post(
				"/resumes/" + Resume.id + "/resume_hidden_fields/update_section",
				{ hidden_field : t.attr("rel"), type : "disable" },
				function(response) {
					if (response.success == 1) {
						t.siblings("input.section_mode").val("disabled");
						t.hide().siblings("span.enable_section").show();
						Resume.blinkUpdatedStatus();
					}
				}
			)
		})
	},
	
	setup_enable_section_action : function() {
		Resume.enable_section.bind('click', function(){
			var t = $(this);
			$.post(
				"/resumes/" + Resume.id + "/resume_hidden_fields/update_section",
				{ hidden_field : t.attr("rel"), type : "enable" },
				function(response) {
					if (response.success == 1) {
						t.siblings("input.section_mode").val("active");
						t.hide().siblings("span.disable_section").hide();
						Resume.blinkUpdatedStatus();
					}
				}
			)
		})
	},
	
	update_resume_settings : function() {
		this.update_resume_settings_btn.click(function() {
			$.ajax({
				url: "/resume_settings/" + Resume.id,
				type: 'PUT',
				data: {
					resume_id: Resume.id,
					resume_setting : {
						status:$("input[name='resume_setting[status]']:checked").val(),
						hide_personal_info:$("#ResumeSettingHidePersonalInfo").is(":checked") ? 1 : 0,
						alert_copy:$("#ResumeSettingAlertCopy").is(":checked") ? 1 : 0,
						email_notification:$("#ResumeSettingEmailNotification").is(":checked") ? 1 : 0,
						show_last_updated:$("#ResumeSettingShowLastUpdated").is(":checked") ? 1 : 0,
						allow_sharing:$("#ResumeSettingAllowSharing").is(":checked") ? 1: 0
					}
				},
				success: function(response) {
					Resume.blinkUpdatedStatus();
				}
			})
		})
	},
	
	blinkUpdatedStatus : function() {
		Resume.updated_status.fadeIn(500);
		setTimeout(function(){ Resume.updated_status.fadeOut(500) }, 2000)
	}
	
}

var Sortable = {
	
	init : function(params) {
		params.target.sortable({
			revert: params.revert,
			stop: function() {
				var order = $(this).sortable('serialize', {key:'order[]'});
				order += '&resume_id=' + $("#ResumeId").val();
				
				var t = $(this);
				
				$.ajax({
					url: params.url,
					type: params.request_type,
					data: order,
					success: Resume.blinkUpdatedStatus
				})
			}
		});
	}
	
}

var Profile = {
	
	init : function() {
		
		this.setup_selectors();
		
		this.setup_hide_complete_notice();
		
		this.setup_profile_overlay();
		
		this.setup_profile_update();
		
		var profile_id = $("#profile_id");
		Profile.id = profile_id.val();
	},
	
	setup_selectors : function() {
		this.edit_profile_btn = $(".edit_profile_btn");
		this.close_profile_overlay_btn = $("#close_profile_overlay");
		this.hide_complete_notice_btn = $("#hide_profile_complete_notice");
		this.update_profile_btn = $("#update_profile_btn");
		this.change_photo_btn = $("#change_photo_btn");
		this.overlay = $("#profile_overlay_wrapper");
		this.edit_profile_message = $("#edit_profile_message");
		this.change_photo_btn = $("#change_photo_btn");
		this.profile_details_input = $("#profile_details_input");
		this.profile_image_cropper = $("#profile_image_cropper");
	},
	
	setup_profile_overlay : function() {
		Profile.edit_profile_btn.bind('click', function(event) {
			event.preventDefault();
			Krb.overlay.fadeIn(function(){ Profile.overlay.fadeIn() })
		})
		
		var that = this;
		
		Profile.close_profile_overlay_btn.click(function() {
			that.edit_profile_message.removeClass().text("").hide();
		})
	},
	
	setup_hide_complete_notice : function() {
		Profile.hide_complete_notice_btn.click(function() {
			Profile.hide_complete_notice();
		})
	},
	
	setup_profile_update : function() {
		Profile.update_profile_btn.click(function() {
			$.ajax({
				url: "/profiles/" + Profile.id,
				type: 'PUT',
				data: $("#profile_form").serialize(),
				success: function(response) {
					if (response.success == 1) {
						Profile.edit_profile_message.removeClass().addClass("result_success").text("Your profile has been updated").show();
					} else {
						Profile.edit_profile_message.removeClass().addClass("result_error").text("An error occurred. Please try again later").show();
					}
				}
			})
		})
	},
	
	hide_complete_notice : function() {
		$.post(
			"/profiles/hide_profile_notice", 
			{}, 
			function() {
				Profile.complete_notice.slideUp(500)
			}
		)
	},
	
	setup_change_photo : function() {
		Profile.change_photo_btn.click(function() {
			Profile.profile_details_input.hide(function() {
				Profile.profile_image_cropper.show();
			});
		})
	}
	
}

$(function(){
	
	Krb.init();
	
	Krb.setup_scrolling($("#back_to_top"), "click", 0, 2000);
	
	Resume.init();
	
	MarkItUp.init();
	
	Profile.init();
	
	Sortable.init({target: $("#sort_resume_sections"), revert: true, url:"/resume_section_orders/" + $("#resume_section_order_id").val(), request_type:'PUT'})
	Sortable.init({target: $("#sort_references"), revert: true, url:"/resumes/" + Resume.id + "/resume_references/order", request_type:'POST'})
	Sortable.init({target: $("#sort_education"), revert: true, url:"/resumes/" + Resume.id +  "/resume_educations/order", request_type:'POST'})
	Sortable.init({target: $("#sort_work_experience"), revert: true, url:"/resumes/" + Resume.id + "/resume_work_experiences/order", request_type:'POST' })
	
	var o = $("#overlay");
	var rs = $("#resume_settings")
	
	//Update resume
	var ru = $("#resume_updated");
	
	//Theme selector
	$("#pick_theme").click(function(){
		$.post(
			"/ajax/update_resume_theme",
			{id: $("#ResumeThemeId").val(), theme_id: $("#theme_dropdown").val(), resume_id: $("#ResumeId").val()},
			function() {
				$("#theme_selector").hide();
				o.hide();
			}
		)
	})
	
	//Add and remove keywords
	var keywordsList = $("#keywordsList");
	var keywordsListWrapper = $("#keywordsListWrapper");
	var keywordsInput = $("#keywordsInput");
	var keywordsMessage = $("#keywordsMessage");
	var keywordsLeft = $("#keywordsLeft");
	
	keywordsInput.keydown(function(event) {

		var code = event.keyCode ? event.keyCode : event.which;
		
		if (code == 13) {
			
			event.preventDefault();
			
			if (keywordsList.children().length > 12) {
				keywordsMessage.text("You've exceeded 20 keywords").addClass("result_error").slideDown();
				return;
			}
			
			var t = $(this);
			
			$.post(
				"/resume_keywords",
				{
					resume_id: $("#ResumeId").val(), 
					resume_keyword: $(this).val()
				},
				function(response){
					t.val("");
					if (response.success == 1) {
						keywordsList.append('<div class="keyword_wrapper"><div class="keyword">' + response.keyword + '</div><div class="keyword_remove" rel="' + response.id + '">x</div></div>');
						update_keywords_left();
					}
				}
			)
		}
		
	});
	
	//Remove keywords	
	$("div.keyword_remove").live('click', function(){
		var t = $(this)
		var url = "/resume_keywords/" + t.attr("rel")
		$.ajax({
			url: url,
			type: 'DELETE',
			asycn: true,
			data: {
				id: t.attr("rel"), 
				resume_id: $("#ResumeId").val(), 
				resume_keyword: $(this).siblings("keyword").text()
			},
			success: function(response){
				t.parent().remove();
				update_keywords_left();
			}
		})
	})
	
	keywordsListWrapper.click(function(){keywordsInput.focus()});
	
	function update_keywords_left() {
		keywordsLeft.text(20 - keywordsList.children().length + ' keywords left');
	}
	
	function get_keywords_list() {
		var kList = new Array();
		keywordsList.children().each(function(index, value){
			kList.push($(this).text());
		})
		//console.log(kList);
		return kList;
	}
	
	//Update keywords
	$("#update_keywords").click(function(){
		$.post(
				"/ajax/update_keywords_list",
				{list:get_keywords_list(), resume_id:$("#ResumeId").val()},
				function(response) {
						if (response == 1) {
							Resume.blinkUpdatedStatus();
						}
				}
		)
	})
	
	//Tweet
	$("#share_thought").click(function(){
		var thought = $("#thoughtbox_message").val();
		if (thought != '' && thought != 'Type your thought here...') {
			$.post(
				"/thoughts",
				{ 
					thought : {
						content : thought
					}
				},
				function(response) {
					if (response.success == 1) {
						alert('Your thought has been published, baby!');
						$("#thoughtbox_message").val("Type your thought here...");
					} else {
						alert('An error occured while sharing your thought. Please wait a few minutes and try again')
					}
					
				}
			)
		}
	})
	
	var thoughtCharsCount = $("#thoughts_chars_count");
	
	$("#thoughtbox_message").focus(function(){
			if ($(this).val() == $(this).attr("rel")) $(this).val("");})
	.blur(function(){
			if ($(this).val() == '') $(this).val($(this).attr("rel"));
	}).keypress(function(){
		var numChars = $(this).val().length;
		if (numChars > 140) {
			//return false;
		} else {
			thoughtCharsCount.text(140 - numChars);
		}
	}).keyup(function(){
		var numChars = $(this).val().length;
		thoughtCharsCount.text(140 - numChars);
	});
	
	$("img.hide_activity_feed_details").bind('click', function(){
		var t = $(this);
		$.post(
			"ajax/hide_activity",
			{activity_id:t.attr("rel")},
			function(response) {
				if (response == 1) {
					var p = t.parent().parent();
					p.slideUp(function(){p.remove()})
				}
			}
		)
	})
	
	
	//Hover label
	$(".focusLabel").focus(function(){
		if ($(this).val() == $(this).attr("rel")) $(this).val("");
	}).blur(function(){
		if ($(this).val() == "") $(this).val($(this).attr("rel"));
	})
	
	//Remove profile comment
	$(".remove_comment").bind('click', function(){
		var t = $(this);
		$.post(
			"/ajax/remove_profile_comment",
			{comment_id:t.attr("rel")},
			function(response) {
				$("#comment_" + t.attr("rel")).fadeOut(400);
			}
		)
	})
	
	//Report profile comment
	$(".report_comment").bind('click', function(){
		var t = $(this);
		$.post(
			"/ajax/report_profile_comment",
			{comment_id:t.attr("rel")},
			function(response) {
				t.removeClass().addClass("comment_reported").attr("title", "This comment has been reported");
			}
		)
	})
 
})