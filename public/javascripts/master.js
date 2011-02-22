$(function(){
	
	//Init MarkItUp
	if ($(".markitup").length) {
		$(".markitup").markItUp(mySettings);
	}
	
	//Init Sortable
	if ($("div.sortable").length) {
		$("#sort_resume_sections").sortable({
			revert: true,
			stop: function() {
				var order = $(this).sortable('serialize',{key:'order[]'});
				order += '&resume_id=' + $("#ResumeId").val();

				var t = $(this);

				$.ajax({
					url: "/resume_section_orders/" + $("#resume_section_order_id").val(),
					type: 'PUT',
					data: order,
					success: blinkUpdatedStatus
				})
			}
		});
		
		$("#sort_references").sortable({
			revert: true,
			stop: function() {
				var resume_id = $("#ResumeId").val();
				var order = $(this).sortable('serialize',{key:'order[]'});
				order += '&resume_id=' + resume_id ;
				
				var t = $(this);
				
				$.ajax({
					url: "/resume_references/order",
					type: 'POST',
					data: order,
					success: blinkUpdatedStatus
				})
			}
		});
		
		$("#sort_education").sortable({
			revert: true,
			stop: function() {
				var resume_id = $("#ResumeId").val();
				var order = $(this).sortable('serialize',{key:'order[]'});
				order += '&resume_id=' + resume_id ;
				
				var t = $(this);
				
				$.ajax({
					url: "/resume_educations/order",
					type: 'POST',
					data: order,
					success: blinkUpdatedStatus
				})
			}
		});
		
		$("#sort_work_experience").sortable({
			revert: true,
			stop: function() {
				var resume_id = $("#ResumeId").val();
				var order = $(this).sortable('serialize',{key:'order[]'});
				order += '&resume_id=' + resume_id ;
				
				var t = $(this);
				
				$.ajax({
					url: "/resume_work_experiences/order",
					type: 'POST',
					data: order,
					success: blinkUpdatedStatus
				})
			}
		})
		
		
	}
	
	//Masked input
	//$("input.period_date").mask("aaa 99");
	$("input.period_date").datepicker({
		changeMonth:true,
		changeYear:true,
		showButtonPanel: true
	}).keypress(function(event){
		return false;
	})
	
	var o = $("#overlay");
	var rs = $("#resume_settings")
	
	$(".trigger_overlay").click(function(){
						$("#" + $(this).attr("rel")).show($(this).attr("effect"), {}, 100, function(){});
						//rs.show();
						o.show();
					})
					
					$(".close_overlay").click(function(){
						
						$(this).parent().fadeOut(function(){
							o.fadeOut();
					})
				
				})
		
	//Edit account settings
	var accountSettingsOverlay = $("#account_settings_overlay_wrapper")
	$("#edit_account_settings").click(function(event){
		event.preventDefault();
		o.fadeIn(function(){accountSettingsOverlay.fadeIn()})
	})
	
	//Hide profile complete notice
	$("#hide_profile_complete_notice").click(function(){
		var p = $(this).parent()
		$.post(
			"profiles/hide_profile_notice",
			{},
			function(){
				$("#profile_complete_notice").slideUp(500)
			}
		)
	})
	
	//Edit profile
	var profileOverlay = $("#profile_overlay_wrapper");
	$(".edit_profile_btn").bind('click', function(event){
		event.preventDefault();
		o.fadeIn(function(){profileOverlay.fadeIn()})
	})
	
	$("#close_profile_overlay").click(function(){
		editProfileMessage.removeClass().text("").hide();
		profileImageCropper.hide();
		profileDetailsInput.show();
		$("#photouploadiframe").attr("src", "profile/upload_photo");
	})
	
	var profileDetailsInput = $("#profile_details_input");
	var profileImageCropper = $("#profile_image_cropper");
	var profileFirstName = $("#profile_first_name");
	var profileLastName = $("#profile_last_name");
	var profileCity = $("#profile_city");
	var profileState = $("#profile_state");
	var profilePostalCode = $("#profile_postal_code");
	var profileCountry = $("#profile_country_id");
	var profileCategory = $("#profile_category");
	var profileIndustry = $("#profile_industry");
	var profileJobTitle = $("#profile_job_title");
	var profileHidden = $("#profile_hidden");
	var editProfileMessage = $("#edit_profile_message");
	
	$("#update_profile_btn").click(function(){
		$.ajax({
			url: "/profiles/" + $("#profile_id").val(),
			type: 'PUT',
			data: {
				profile : {
					first_name:profileFirstName.val(),
					last_name:profileLastName.val(),
					city:profileCity.val(),
					state:profileState.val(),
					postal_code:profilePostalCode.val(),
					country_id:profileCountry.val(),
					job_category:profileCategory.val(),
					job_industry:profileIndustry.val(),
					job_title:profileJobTitle.val(),
					hidden:(profileHidden.is(":checked") ? 1 : 0)
				}
			},
			success: function(response) {
				
				if (response.success == 1) {
					editProfileMessage.removeClass().addClass("result_success").text("Your profile has been updated").show();
				} else {
					editProfileMessage.removeClass().addClass("result_error").text("An error occurred. Please try again later").show();
				}
			}
		})
	})
	
	$("#change_photo_btn").click(function(){
		profileDetailsInput.hide();
		profileImageCropper.show();
	})
	
	//Account links
	var accountLinks = $("#account_links");
	
	$("#username_tab").hoverIntent({
		over: function(){
			accountLinks.fadeIn(500);
		},
		timeout: 500,
		out: function(){
			accountLinks.fadeOut();
		}
	})
	
	$("#close_account_links").click(function(event){
		accountLinks.fadeOut(500);
	})
	
	//Update resume
	var ru = $("#resume_updated");
	
	$(".delete").click(function(event){
		event.preventDefault();

		if (confirm('Are you sure you want to delete this resume? This action cannot be undone')) {
		 			window.location.href = $(this).attr("href");
		}
	})
	
	//Update resume settings
	$("#update_resume_settings").click(function(){
		$.ajax({
			url: "/resume_settings/" + $("#resume_settings_id").val(),
			type: 'PUT',
			data: {
				resume_id: $("#ResumeId").val(),
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
				blinkUpdatedStatus();
			}
		})
	})
	
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
	
		$("h2.section_name_editable").bind('click',
				function(){
					$(this).hide().siblings().show();
				}
			)
		
		$("span.update_section_name").bind(
			'click',
			function(){
				
				var t = $(this);
				
				var updatedName = t.siblings("input[type=text]").val();
				
				if (updatedName == '') {
					alert('Please enter a new name for this section');
					return;
				}
				
				$.post(
					"/ajax/update_section_name",
					{id:t.siblings("input[type=hidden]").val(), resume_id:$("#ResumeId").val(), section:t.attr("rel"), name:updatedName},
					function(response){
						if (response == 1) {
							t.siblings("input[type=text]").trigger("click");
							blinkUpdatedStatus();
						}
					}
				)
			})
			
			$("span.cancel_update_section_name").bind('click', function(){
				var _this = $(this);
				_this.hide();
				_this.siblings().hide().siblings("h2").show();
			})
	
	//Options hover
	$("div.section_options").hover(
		function(){
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
		function(){
			$(this).children().hide();
			$(this).children("div.options_label").show();
		}
	)
	
	//Disable section
	$("a.disable_section").click(function(){
		var t = $(this);
		$.post(
			"/ajax/update_section",
			{resume_id:$("#ResumeId").val(), hidden_field:t.attr("rel"), action:"disable"},
			function(response) {
				if (response == 1) {
					t.siblings("input.section_mode").val("disabled");
					t.hide().siblings("span.enable_section").show();
					blinkUpdatedStatus();
				}
			}
		)
	})
	
	//Enable section
	$("a.enable_section").click(function(){
		var t = $(this);
		$.post(
			"/ajax/update_section",
			{resume_id:$("#ResumeId").val(), hidden_field:t.attr("rel"), action:"enable"},
			function(response) {
				if (response == 1) {
					t.siblings("input.section_mode").val("active");
					t.hide().siblings("span.disable_section").hide();
					blinkUpdatedStatus();
				}
			}
		)
	})
	
	$("#upload_photo").click(function(){
		$("#photo-uploader").slideDown();
		$("#photouploadiframe").attr("src", $(this).attr("src"));
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
							blinkUpdatedStatus();
						}
				}
		)
	})
	
	//Tweet
	$("#share_thought").click(function(){
		var thought = $("#thoughtbox_message").val();
		if (thought != '' && thought != 'Type your thought here...') {
			$.post(
				"/thoughts/new",
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
	
	var favJobsList = $("#fav_jobs_list");
					
					$("img.save_job").live('click', function(){
						var t = $(this);
						$.post(
							"/ajax/fav_job",
							{job_id:t.attr("rel")},
							function(response) {
								var _response = $.parseJSON(response);
								if (_response.result == 1) {
									//alert('Job has been added to your favorites list');
									$("#no_fav_jobs").hide();
									var favItem = $("<li class=\"white_region\" id=\"fav_job_item_" + _response.job_id + "\"> \
										<div class=\"inner\"> \
											<div class=\"left\"> \
												<a class=\"job_title\" href=\"/jobs/view/company:" + _response.company_slug + "/slug:" + _response.job_slug + "\">" + _response.job_title 
												+ "</a><p>at " + _response.company_name + " - <span class=\"stamp\">" + _response.posted_date +  "</span></p> \
											</div> \
											<div class=\"options\"> \
												<img rel=\"" + _response.job_id + "\" title=\"Remove this job\" class=\"remove_fav_job\" src=\"/img/Basic_set_PNG/delete_16.png\" /></div> \
										</div> \
									</li>");
									favJobsList.removeClass().prepend(favItem);
								} else if (response == -1) {
									alert('This job is already in your favorites list');
								}
							}
						)
					})
				
				$("img.unsave_job").live('click', function(){
						var t = $(this);
						$.post(
							"/ajax/unfav_job",
							{job_id:t.attr("rel")},
							function(response) {
								var p = $("#fav_job_item_" + t.attr("rel"));
								p.slideUp(function(){p.remove()});
							}
						)
					})
	
	//Slugify
	$("input.need_slug").keyup(function(){
			var slug = convertToSlug($(this).val());
			var sluggedObject = $(this).attr("rel");
			$("#slug_"+sluggedObject).val(slug);
		}).change(function(){$(this).trigger('keyup')})

	function convertToSlug(Text) {
		return Text.toLowerCase().replace(/_+/g, '-').replace(/[^\w- ]+/g,'').replace(/ +/g,'-');
	}
	
	//Hover label
	$(".focusLabel").focus(function(){
		if ($(this).val() == $(this).attr("rel")) $(this).val("");
	}).blur(function(){
		if ($(this).val() == "") $(this).val($(this).attr("rel"));
	})
	
	//Search box
	$("img.start_search_btn").click(function(){
		var siblingSearch = $(this).siblings(".focusLabel");
		if (siblingSearch.val() != siblingSearch.attr("rel") && siblingSearch.val() != '') $(this).parent().submit();
	})

	//Save search results
	var ssro = $("#save_search_results_overlay");
	
	$("img.save_search_results_trigger").click(function(){
		o.show();
		ssro.show();
	})
	
	$("img.save_search_results").click(function(){
		var name = $("#search_result_name").val();
		if (name) {
			$.post(
				"/ajax/save_search_results",
				{
					name:name,
					type:$(this).attr("type"),
					url:location.href
				},
				function(response){
					if (response == 1) {
						alert('Your search results have been saved');
						ssro.hide();
						o.hide();
					}
				}

			)
		}
	})
	
	//Remove search results
	$("img.remove_search_result").bind('click', function(){
		var t = $(this);
		$.post(
			"ajax/remove_search_results",
			{id:$(this).attr("rel")},
			function() {
				t.parent().parent().parent().remove();
			}
		)
	})
	
	//Close overlay on entire site
	$("img.close_overlay").bind('click', function(event){
		event.preventDefault();
		$(this).parent().fadeOut(function(){
			o.fadeOut();
		})
	})
	
	//Recommend blog post
	$("#recommend_post").click(function() {
		var t = $(this);
		$.post(
			"/resume/ajax/recommend_post",
			{id:t.attr("rel")},
			function(){
				t.parent().text("Thank you for your recommendation");
			}
		)
	})
	
	//View job applicant details
	var jobApplicantDetailsOverlay = $("#job_applicant_details_overlay");
	var applicantFirstName = $("#applicant_first_name");
	var applicantLastName = $("#applicant_last_name");
	var applicantEmail = $("#applicant_email");
	var applicantPhoneNumber = $("#applicant_phone_number");
	var applicantCity = $("#applicant_city");
	var applicantState = $("#applicant_state");
	var applicantResume = $("#applicant_resume");
	var applicantCoverLetter = $("#applicant_cover_letter");
	var applicantProfile = $("#applicant_profile");
	
	$(".view_applicant_details").click(function(){
		var t = $(this);
		o.fadeIn(function(){
			applicantFirstName.val(t.siblings(".applicant_first_name").val());
			applicantLastName.val(t.siblings(".applicant_last_name").val());
 			applicantEmail.val(t.siblings(".applicant_email").val());
			applicantPhoneNumber.val(t.siblings(".applicant_phone_number").val());
			applicantCity.val(t.siblings(".applicant_city").val());
			applicantState.val(t.siblings(".applicant_state").val());
			applicantResume.attr("href", "/files/resume/" + t.siblings(".applicant_resume").val());
			var cover_letter = t.siblings(".applicant_cover_letter").html();
			applicantProfile.attr("href", "/profile/" + t.siblings(".applicant_username").val()); 
			if (cover_letter) {
				applicantCoverLetter.html(cover_letter);
			} else {
				applicantCoverLetter.html("n/a");
			}
			
			jobApplicantDetailsOverlay.fadeIn();
		})
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
	
	//Blink updated status
	var updatedStatus = $("#updated_status");
	function blinkUpdatedStatus() {
		updatedStatus.fadeIn(500);
		setTimeout(function(){updatedStatus.fadeOut(500)}, 2000);
	}
	
	function showAccountSettingsUpdatedMessage(result, message) {
		accountSettingsMessage.removeClass().addClass(result == 'error' ? "result_error" : "result_success").text(message).fadeIn(500);
		setTimeout(function(){accountSettingsMessage.fadeOut(500)}, 2000);
	}
	
	//Update Account email and password
	var accountEmail = $("#account_email");
	var accountPassword = $("#account_password");
	var accountSettingsMessage = $("#edit_account_settings_message");
	$("#update_account_password_btn").click(function(){
		var password = accountPassword.val();
		if (password) {
			$.post(
				"/ajax/update_account_password",
				{password:password},
				function(response) {
					var _response = $.parseJSON(response);
					var _result = _response.result;
					if (_result == -1 || _result == -2 || _result == -3) {
						showAccountSettingsUpdatedMessage("error", _response.message);
					} else {
						showAccountSettingsUpdatedMessage("success", _response.message);
					}
				}
			)
		}
	})
	
	$("#update_account_email_btn").click(function(){
		var email = accountEmail.val();
		if (email) {
			$.post(
				"/ajax/update_account_email",
				{email:email},
				function(response) {
					var _response = $.parseJSON(response);
					var _result = _response.result;
					if (_result == -1 || _result == -2 || _result == -3) {
						showAccountSettingsUpdatedMessage("error", _response.message);
					} else {
						showAccountSettingsUpdatedMessage("success", _response.message);
					}
				}
			)
		}
	})
 
})

function cancel_photo_upload() {
	$("#profile_image_cropper").hide();
	$("#profile_details_input").show();
	$("#photouploadiframe").attr("src", "profile/upload_photo");
}