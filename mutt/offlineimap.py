#!/usr/bin/env python
# -*- coding: utf-8 -*-

import re, subprocess
import sys, os

def get_security_command(account=None, item_name=None, command='find-generic-password', label='Gmail Oauth2'):
    params = {
        'security': '/usr/bin/security',
        'command': command,
        'account': account,
        'item': item_name,
        'label': label,
        'keychain': '/Users/morgan/Library/Keychains/login.keychain',
    }

    return "sudo -u morgan %(security)s -v %(command)s -g -a %(account)s " \
            "-D '%(item)s' -l '%(label)s' %(keychain)s" % params


def get_oauth_credentials(account, item_name=None):
    cmd = get_security_command(account=account, item_name=item_name)
    output = subprocess.check_output(cmd, shell=True, stderr=subprocess.STDOUT)
    outtext = [l for l in output.splitlines() if l.startswith('password: ')][0]
    cred = re.match(r'password: "(.*)"', outtext).group(1)
    return bytes(cred)


def get_keychain_pass(account=None, server=None):
    params = {
        'security': '/usr/bin/security',
        'command': 'find-internet-password',
        'account': account,
        'item': server,
        'keychain': '/Users/morgan/Library/Keychains/login.keychain',
    }
    cmd = "sudo -u morgan %(security)s -v %(command)s -g -a %(account)s " \
            "-s '%(server)s' %(keychain)s" % params
    output = subprocess.check_output(cmd, shell=True, stderr=subprocess.STDOUT)
    outtext = [l for l in output.splitlines()
               if l.startswith('password: ')][0]
    cred = re.match(r'password: "(.*)"', outtext).group(1)
    return bytes(cred)
    pass


def get_client_id(account):
    """Get the Oauth2 client id for a given account

    :account: [string]
    :returns: [bytes] an instance of `bytes` that contains the client id

    """
    return get_oauth_credentials(account, item_name='Client ID')


def get_client_secret(account):
    """Get the Oauth2 client secret for a given account

    :account: [string]
    :returns: [bytes] an instance of `bytes` that contains the client secret

    """
    return get_oauth_credentials(account, item_name='Client Secret')


def get_access_token(account):
    return get_oauth_credentials(account, item_name='Access Token')


def get_refresh_token(account):
    return get_oauth_credentials(account, item_name='Refresh Token')

GMAIL_DIR_MAP = {
    '[Gmail]/Drafts': 'drafts',
    '[Gmail]/Sent Mail': 'sent',
    '[Gmail]/Starred': 'flagged',
    '[Gmail]/Trash': 'trash',
    '[Gmail]/All Mail': 'archive',
}

GMAIL_DIR_MAP_REVERSE = dict((v, k) for k,v in GMAIL_DIR_MAP.iteritems())
