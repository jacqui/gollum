# URL Helpers for accessing Sinatra methods in Mustache
module Precious
  module UrlHelpers
    include ::Sinatra::Helpers

    def create_url
      url("create")
    end

    def url_for_action_name(action, name)
      url("#{action}/#{name}")
    end

    def edit_url(name)
      url_for_action_name('edit', name)
    end

    def edit_url_for_escaped_name
      edit_url(escaped_name)
    end

    def history_url(name)
      url_for_action_name('history', name)
    end

    def history_url_for_escaped_name
      history_url(escaped_name)
    end

    def show_url(name)
      url(name)
    end

    def show_url_for_escaped_name
      show_url(escaped_name)
    end

    def search_url
      url('search')
    end

    def all_pages_url
      url('pages')
    end

    def compare_url_for_escaped_name
      url_for_action_name('compare', escaped_name)
    end

    def compare_versions_url(name, version1, version2)
      url_for_action_name('compare', name + '/' + version1 + '...' + version2)
    end

    def revert_url_for_escaped_name
      url_for_action_name('revert', escaped_name)
    end

    def preview_url
      url('preview')
    end

    def base_url
      url('/')
    end
  end
end
