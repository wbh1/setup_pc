# SETUP_PC
This is an Ansible playbook + roles intended to be run against a local machine in order to configure/install things that I commonly use / require on any of my laptops.

Before running, it is presumed that you have installed Ansible (not just `ansible-core`  -- you need the extra collections from the `ansible` package).


## Running
```bash
# Install role deps
# ansible-galaxy install -r roles/requirements.yml --roles-path ./roles

ansible-playbook playbook.yml -K
```

## Compatability
Some things are only compatible with Mac. I'm trying to achieve parity with it and Linux, but it's a work in progress.

For my Framework laptop with a fingerprint reader, you must use a different `become-method` in order to work around the fingerprint reader's PAM module not allowing for the password being passed by `ansible-playbook`.

```bash
ansible-playbook --become-method=su -K playbook.yml
```

Alternatively, you can disable the PAM module temporarily in Fedora:
```bash
sudo authselect disable-feature with-fingerprint
```

## Sources
- [dircolors](https://github.com/seebi/dircolors-solarized)
