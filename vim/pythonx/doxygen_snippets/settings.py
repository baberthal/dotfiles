"""
File: settings.py
Author: J. Morgan Lieberthal
Email: morgan@jmorgan.org
Github: https://github.com/baberthal
Description: Doxygen Snippets Settings Class
"""

# Settings in vim:
#   * g:snips_author
#   * g:snips_email
#   * g:snips_github
#
# Settings to add:
#   * g:doxy_brief_tag_pre
#   * g:doxy_brief_tag_post
#   * g:doxy_param_tag_pre
#   * g:doxy_param_tag_post
#   * g:doxy_return_tag
#   * g:doxy_block_header
#   * g:doxy_block_footer
#   * g:doxy_license_tag
#   * g:doxy_file_tag
#   * g:doxy_author_tag
#   * g:doxy_date_tag
#   * g:doxy_version_tag
#   * g:doxy_undoc_tag
#   * g:doxy_block_tag
#   * g:doxy_class_tag
#   * g:doxy_cin_options
#   * g:doxy_start_comment_tag
#   * g:doxy_start_comment_block
#   * g:doxy_inter_comment_tag
#   * g:doxy_inter_comment_block
#   * g:doxy_end_comment_tag
#   * g:doxy_end_comment_block
#   * g:doxy_comment_type


class DoxygenSettings(object):
    """Stores settings for Doxygen Snippets"""

    def __init__(self, arg):
        super(DoxygenSettings, self).__init__()
        self.arg = arg
