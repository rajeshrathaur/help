<style>

a,
a:hover {
	text-decoration: none !important;
}

.login-section {
	max-width: 48%;
	margin: 0 auto;
}

.login-inner-section {
	-webkit-box-shadow: 0 4px 20px 0 rgba(0, 0, 0, .1);
	box-shadow: 0 4px 20px 0 rgba(0, 0, 0, .1);
	border-radius: .5rem;
	background: #fff;
	.login-form {
		width: 100%;
		display: block;
		position: relative;
		-webkit-transition: all .3s ease-in-out;
		transition: all .3s ease-in-out;
		padding: 1em;
	}
}

.btn-button {
	display: inline-block;
	font-weight: 400;
	color: #212529;
	text-align: center;
	vertical-align: middle;
	user-select: none;
	background-color: transparent;
	border: 1px solid transparent;
	padding: 5px 15px;
	font-size: 1rem;
	line-height: 1.5;
	border-radius: 0.25rem;
	transition: color 0.15s ease-in-out, background-color 0.15s ease-in-out, border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
}

.btn-button-color {
	background-image: -webkit-linear-gradient(#1479ad, #104ba5);
	background-image: linear-gradient(#1479ad, #104ba5);
}

.login-screen-iamge {
	text-align: center;
	border-bottom: 2px solid #f0b928;
}

@media (max-width: 992px) {
  .login-section {
     max-width: 100%;
  }
}

@media (max-width: 1240px) {
  .login-section {
     max-width: 100%;
  }
}


</style>

<%@ include file="/init.jsp" %>

<c:choose>
	<c:when test="<%= themeDisplay.isSignedIn() %>">

		<%
		String signedInAs = HtmlUtil.escape(user.getFullName());

		if (themeDisplay.isShowMyAccountIcon() && (themeDisplay.getURLMyAccount() != null)) {
			String myAccountURL = String.valueOf(themeDisplay.getURLMyAccount());

			signedInAs = "<a class=\"signed-in\" href=\"" + HtmlUtil.escape(myAccountURL) + "\">" + signedInAs + "</a>";
		}
		%>

		<liferay-ui:message arguments="<%= signedInAs %>" key="you-are-signed-in-as-x" translateArguments="<%= false %>" />
	</c:when>
	<c:otherwise>

		<%
		String formName = "loginForm";

		if (windowState.equals(LiferayWindowState.EXCLUSIVE)) {
			formName += "Modal";
		}

		String redirect = ParamUtil.getString(request, "redirect");

		String login = (String)SessionErrors.get(renderRequest, "login");

		if (Validator.isNull(login)) {
			login = LoginUtil.getLogin(request, "login", company);
		}

		String password = StringPool.BLANK;
		boolean rememberMe = ParamUtil.getBoolean(request, "rememberMe");

		if (Validator.isNull(authType)) {
			authType = company.getAuthType();
		}
		%>

		<div class="login-container">
			<portlet:actionURL name="/login/login" secure="<%= PropsValues.COMPANY_SECURITY_AUTH_REQUIRES_HTTPS || request.isSecure() %>" var="loginURL">
				<portlet:param name="mvcRenderCommandName" value="/login/login" />
			</portlet:actionURL>
			
			<section class="login-section">
              <div class="login-inner-section">
               <div class="row">
                <div class="col-md-12">
                  <div class="login-form p-5">
                 <div class="login-screen-iamge mb-4">
                  <img class="pb-3" src="<%=request.getContextPath()%>/image/logo.png" alt="Logo">
                 </div>
			<aui:form action="<%= loginURL %>" autocomplete='<%= PropsValues.COMPANY_SECURITY_LOGIN_FORM_AUTOCOMPLETE ? "on" : "off" %>' cssClass="sign-in-form" method="post" name="<%= formName %>" onSubmit="event.preventDefault();" validateOnBlur="<%= false %>">
				<aui:input name="saveLastPath" type="hidden" value="<%= false %>" />
				<aui:input name="redirect" type="hidden" value="<%= redirect %>" />
				<aui:input name="doActionAfterLogin" type="hidden" value="<%= portletName.equals(PortletKeys.FAST_LOGIN) ? true : false %>" />

				<div class="inline-alert-container lfr-alert-container"></div>

				<liferay-util:dynamic-include key="com.liferay.login.web#/login.jsp#alertPre" />

				<c:choose>
					<c:when test='<%= SessionMessages.contains(request, "forgotPasswordSent") %>'>
						<div class="alert alert-success">
							<liferay-ui:message key="your-request-completed-successfully" />
						</div>
					</c:when>
					<c:when test='<%= SessionMessages.contains(request, "userAdded") %>'>

						<%
						String userEmailAddress = (String)SessionMessages.get(request, "userAdded");
						%>

						<div class="alert alert-success">
							<liferay-ui:message key="thank-you-for-creating-an-account" />

							<c:if test="<%= company.isStrangersVerify() %>">
								<liferay-ui:message arguments="<%= HtmlUtil.escape(userEmailAddress) %>" key="your-email-verification-code-was-sent-to-x" translateArguments="<%= false %>" />
							</c:if>

							<c:if test="<%= PrefsPropsUtil.getBoolean(company.getCompanyId(), PropsKeys.ADMIN_EMAIL_USER_ADDED_ENABLED) %>">
								<liferay-ui:message arguments="<%= HtmlUtil.escape(userEmailAddress) %>" key="your-password-was-sent-to-x" translateArguments="<%= false %>" />
							</c:if>
						</div>
					</c:when>
					<c:when test='<%= SessionMessages.contains(request, "userPending") %>'>

						<%
						String userEmailAddress = (String)SessionMessages.get(request, "userPending");
						%>

						<div class="alert alert-success">
							<liferay-ui:message arguments="<%= HtmlUtil.escape(userEmailAddress) %>" key="thank-you-for-creating-an-account.-you-will-be-notified-via-email-at-x-when-your-account-has-been-approved" translateArguments="<%= false %>" />
						</div>
					</c:when>
				</c:choose>

				<liferay-ui:error exception="<%= AuthException.class %>" message="authentication-failed" />
				<liferay-ui:error exception="<%= CompanyMaxUsersException.class %>" message="unable-to-log-in-because-the-maximum-number-of-users-has-been-reached" />
				<liferay-ui:error exception="<%= CookieNotSupportedException.class %>" message="authentication-failed-please-enable-browser-cookies" />
				<liferay-ui:error exception="<%= NoSuchUserException.class %>" message="authentication-failed" />
				<liferay-ui:error exception="<%= PasswordExpiredException.class %>" message="your-password-has-expired" />
				<liferay-ui:error exception="<%= UserEmailAddressException.MustNotBeNull.class %>" message="please-enter-an-email-address" />
				<liferay-ui:error exception="<%= UserLockoutException.LDAPLockout.class %>" message="this-account-is-locked" />

				<liferay-ui:error exception="<%= UserLockoutException.PasswordPolicyLockout.class %>">

					<%
					UserLockoutException.PasswordPolicyLockout ule = (UserLockoutException.PasswordPolicyLockout)errorException;
					%>

					<c:choose>
						<c:when test="<%= ule.passwordPolicy.isRequireUnlock() %>">
							<liferay-ui:message key="this-account-is-locked" />
						</c:when>
						<c:otherwise>

							<%
							Format dateFormat = FastDateFormatFactoryUtil.getDateTime(FastDateFormatConstants.SHORT, FastDateFormatConstants.LONG, locale, TimeZone.getTimeZone(ule.user.getTimeZoneId()));
							%>

							<liferay-ui:message arguments="<%= dateFormat.format(ule.user.getUnlockDate()) %>" key="this-account-is-locked-until-x" translateArguments="<%= false %>" />
						</c:otherwise>
					</c:choose>
				</liferay-ui:error>

				<liferay-ui:error exception="<%= UserPasswordException.class %>" message="authentication-failed" />
				<liferay-ui:error exception="<%= UserScreenNameException.MustNotBeNull.class %>" message="the-screen-name-cannot-be-blank" />

				<liferay-util:dynamic-include key="com.liferay.login.web#/login.jsp#alertPost" />

				<aui:fieldset>

					<%
					String loginLabel = null;

					if (authType.equals(CompanyConstants.AUTH_TYPE_EA)) {
						loginLabel = "email-address";
					}
					else if (authType.equals(CompanyConstants.AUTH_TYPE_SN)) {
						loginLabel = "screen-name";
					}
					else if (authType.equals(CompanyConstants.AUTH_TYPE_ID)) {
						loginLabel = "id";
					}
					%>

					<aui:input autoFocus="<%= windowState.equals(LiferayWindowState.EXCLUSIVE) || windowState.equals(WindowState.MAXIMIZED) %>" cssClass="clearable" label="<%= loginLabel %>" name="login" showRequiredLabel="<%= false %>" type="text" value="<%= login %>">
						<aui:validator name="required" />

						<c:if test="<%= authType.equals(CompanyConstants.AUTH_TYPE_EA) %>">
							<aui:validator name="email" />
						</c:if>
					</aui:input>

					<aui:input name="password" showRequiredLabel="<%= false %>" type="password" value="<%= password %>">
						<aui:validator name="required" />
					</aui:input>

					<span id="<portlet:namespace />passwordCapsLockSpan" style="display: none;"><liferay-ui:message key="caps-lock-is-on" /></span>

					<c:if test="<%= company.isAutoLogin() && !PropsValues.SESSION_DISABLED %>">
						<aui:input checked="<%= rememberMe %>" name="rememberMe" type="checkbox" />
					</c:if>
				</aui:fieldset>

				 <button type="submit" class="btn-button btn-button-color text-white mb-4">Sign In</button>
			</aui:form>
			

			<%@ include file="/navigation.jspf" %>
			</div>
			</div>
        </div>
        </div>
        </section>
		</div>

		<aui:script sandbox="<%= true %>">
			var form = document.getElementById('<portlet:namespace /><%= formName %>');

			if (form) {
				form.addEventListener(
					'submit',
					function(event) {
						<c:if test="<%= Validator.isNotNull(redirect) %>">
							var redirect = form.querySelector('#<portlet:namespace />redirect');

							if (redirect) {
								var redirectVal = redirect.getAttribute('value');

								redirect.setAttribute('value', redirectVal + window.location.hash);
							}
						</c:if>

						submitForm(form);
					}
				);

				var password = form.querySelector('#<portlet:namespace />password');

				if (password) {
					password.addEventListener(
						'keypress',
						function(event) {
							Liferay.Util.showCapsLock(event, '<portlet:namespace />passwordCapsLockSpan');
						}
					);
				}
			}
		</aui:script>
	</c:otherwise>
</c:choose>