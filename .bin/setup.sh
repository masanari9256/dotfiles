# GitHub SSH Setup
echo -e "\033[0;34m- GitHub SSH Setup...\033[0m"
ssh-keygen -N '' -f ${SSH_KEY_PATH}/github_rsa
pbcopy < ${SSH_KEY_PATH}/github_rsa.pub
echo "SSH key copied to clipboard. Paste it into GitHub."
sleep 1; echo "Open the GitHub settings page:"
sleep 1; open https://github.com/settings/ssh/new
