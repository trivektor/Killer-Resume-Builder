var Message = {
	delete_confirmation : "Are you sure you want to delete this resume? This action cannot be undone",
	blank_section_name : "Please enter a new name for this section",
	thought_published_success : "Your thought has been published, baby!",
	thought_published_failed : "An error occured while sharing your thought. Please wait a few minutes and try again",
	thoughtbox_original : "Type your thought here...",
	keywords_limit_exceeded : "You've exceeded 20 keywords",
	comment_reported : "This comment has been reported"
}

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
			if (confirm(Message.delete_confirmation)) {
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
		
		this.setup_keywords_input_keydown_action();
		
		this.setup_remove_keyword_action();
	},
	
	setup_selectors : function() {
		this.updated_status = $("#updated_status");
		this.update_resume_settings_btn = $("#update_resume_settings");
		this.editable_section_name = $(".section_name_editable");
		this.section_name_editor = $("input.section_name_editor");
		this.update_section_name = $("span.update_section_name");
		this.cancel_update_section_name = $("span.cancel_update_section_name");
		this.section_options = $(".section_options");
		this.disable_section = $(".disable_section");
		this.enable_section = $(".enable_section");
		this.keywordsList = $("#keywordsList");
		this.keywordsListWrapper = $("#keywordsListWrapper");
		this.keywordsInput = $("#keywordsInput");
		this.keywordsMessage = $("#keywordsMessage");
		this.keywordsLeft = $("#keywordsLeft");
		this.keyword_remove = $(".keyword_remove");
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
				alert(Message.blank_section_name);
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
	},
	
	setup_keywords_input_keydown_action : function() {
		Resume.keywordsInput.keydown(function(event) {
			
			var code = event.keyCode ? event.keyCode : event.which;

			if (code == 13) {
				
				event.preventDefault();

				if (Resume.keywordsList.children().length > 12) {
					Resume.keywordsMessage.text(Message.keywords_limit_exceeded).addClass("result_error").slideDown();
					return;
				}

				var t = $(this);

				$.post(
					"/resume_keywords",
					{
						resume_id: Resume.id, 
						resume_keyword: $(this).val()
					},
					function(response){
						t.val("");
						if (response.success == 1) {
							Resume.keywordsList.append(Resume.keyword_wrapper_template(response.keyword, response.id));
							Resume.update_keywords_left();
						}
					}
				)
			}
		})
	},
	
	keyword_wrapper_template : function(keyword, id) {
		return '<div class="keyword_wrapper"><div class="keyword">' + keyword + '</div><div class="keyword_remove" rel="' + id + '">x</div></div>'
	},
	
	update_keywords_left : function() {
		Resume.keywordsLeft.text(20 - Resume.keywordsList.children().length + ' keywords left');
	},
	
	setup_remove_keyword_action : function() {
		Resume.keyword_remove.live('click', function() {
			var t = $(this)
			var url = "/resume_keywords/" + t.attr("rel")
			$.ajax({
				url: url,
				type: 'DELETE',
				asycn: true,
				data: {
					id: t.attr("rel"), 
					resume_id: Resume.id,
					resume_keyword: $(this).siblings("keyword").text()
				},
				success: function(response){
					t.parent().remove();
					Resume.update_keywords_left();
				}
			})
		})
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
		
		this.setup_change_photo_action();
		this.setup_profile_snapback_action();
		
		this.setup_report_comment();
		this.setup_remove_comment();
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
		this.complete_notice = $("#profile_complete_notice");
		this.back_to_profile = $("#back_to_edit_profile");
		this.report_comment = $(".report_comment");
		this.remove_comment = $(".remove_comment");
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
	
	setup_change_photo_action : function() {
		Profile.change_photo_btn.click(function() {
			Profile.profile_details_input.hide(function() {
				Profile.profile_image_cropper.show();
			});
		})
	},
	
	setup_profile_snapback_action : function() {
		Profile.back_to_profile.click(function() {
			Profile.profile_image_cropper.hide(function() {
				Profile.profile_details_input.show();
			})
		})
	},
	
	setup_report_comment : function() {
		this.report_comment.bind('click', function() {
			$.ajax({
				url: '/user_threads/' + $(this).attr("rel") + '/report_comment',
				type: 'POST',
				data: {},
				success: function(response) {
					if (response.success == 1) {
						alert('The comment has been reported')
					}
				}
			})
		})
	},
	
	setup_remove_comment : function() {
		this.remove_comment.bind('click', function() {
			var thread_id = $(this).attr("rel");
			$.ajax({
				url: '/user_threads/' + thread_id + '/remove_comment',
				type: 'POST',
				data: {},
				success: function(response) {
					if (response.success == 1) {
						$("#thread_" + thread_id).slideUp().remove();
					}
				}
			})
		})
	}
	
}

var Thought = {
	
	init : function() {
		this.setup_selectors();
		this.setup_share_thought_action();
		this.thoughtbox_count_chars();
	},
	
	setup_selectors : function() {
		this.thoughtbox = $("#thoughtbox_message");
		this.share_thought_btn = $("#share_thought");
		this.thoughtCharsCount = $("#thoughts_chars_count");
	},
	
	thoughtbox_count_chars : function() {
		this.thoughtbox
			.focus(Thought.thoughtbox_focus)
			.blur(Thought.thoughtbox_blur)
			.keypress(Thought.thoughtbox_keypress)
			.keyup(Thought.thoughtbox_keyup);
	},
	
	thoughtbox_focus : function() {
		if ($(this).val() == $(this).attr("rel")) $(this).val("");
	},
	
	thoughtbox_blur : function() {
		if ($(this).val() == '') $(this).val($(this).attr("rel"));
	},
	
	thoughtbox_keypress : function() {
		var numChars = $(this).val().length;
		if (numChars <= 140) {
			Thought.thoughtCharsCount.text(140 - numChars);
		}
	},
	
	thoughtbox_keyup : function(){
		var numChars = $(this).val().length;
		Thought.thoughtCharsCount.text(140 - numChars);
	},
	
	setup_share_thought_action : function() {
		
		this.share_thought_btn.click(function() {
			var thought = Thought.thoughtbox.val();
			
			if (thought != '' && thought != Message.thoughtbox_original) {
				$.post(
					"/thoughts",
					{ thought : { content : thought } },
					function(response) {
						if (response.success == 1) {
							alert(Message.thought_published_success);
							Thought.thoughtbox.val(Message.thoughtbox_original)
						} else {
							alert(Message.thought_published_fail)
						}
					}
				)
			}
		})
	}
	
}

$(function(){
	
	Krb.init();
	
	Krb.setup_scrolling($("#back_to_top"), "click", 0, 2000);
	
	Resume.init();
	
	MarkItUp.init();
	
	Profile.init();
	
	Thought.init();
	
	Sortable.init({target: $("#sort_resume_sections"), revert: true, url:"/resumes/" + Resume.id + "/resume_section_orders", request_type:'PUT'})
	Sortable.init({target: $("#sort_references"), revert: true, url:"/resumes/" + Resume.id + "/resume_references/order", request_type:'POST'})
	Sortable.init({target: $("#sort_education"), revert: true, url:"/resumes/" + Resume.id +  "/resume_educations/order", request_type:'POST'})
	Sortable.init({target: $("#sort_work_experience"), revert: true, url:"/resumes/" + Resume.id + "/resume_work_experiences/order", request_type:'POST' })
	
	//keywordsListWrapper.click(function(){keywordsInput.focus()});
	
	//Hover label
	$(".focusLabel").focus(function(){
		if ($(this).val() == $(this).attr("rel")) $(this).val("");
	}).blur(function(){
		if ($(this).val() == "") $(this).val($(this).attr("rel"));
	})
 
})