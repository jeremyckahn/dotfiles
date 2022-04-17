# Improve scrolling in Firefox:
# https://www.reddit.com/r/firefox/comments/pim2dz/pro_tip_if_youre_having_scrolling_issues_with/
export MOZ_USE_XINPUT2=1

# ~/.env.profile is meant to be an untracked file for bespoke environment configuration
[ -s ~/.env.profile ] && source ~/.env.profile
