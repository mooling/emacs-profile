```bash
ssh-keygen -t rsa -C "mooling@yeah.net"
cat ~/.ssh/id_rsa.pub
ssh -T git@github.com

git config --global user.name "liu shaolin"
git config --global user.email "mooling@yeah.net"

git clone git@github.com:mooling/emacs-profile.git liushao
git submodule init
git submodule update
```