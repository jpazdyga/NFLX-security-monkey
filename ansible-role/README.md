Security Monkey Ansible Role
======================

Description
-----------

This repository contains Security Monkey role for Ansible.


Installation
------------

Installation is done by ansible-galaxy command, which deploys the role into the default role path.

Variables
---------

I'm working on it. 

How to use that role
--------------------

Basically, To configure the host as Security Monkey server, you'll need to run a playbook containing

	- hosts: secmonkeys
	  sudo: yes
	  remote_user: jenkins-agent
	  roles:
	    - { role: security-monkey }

