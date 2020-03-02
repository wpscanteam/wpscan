# frozen_string_literal: true

module WPScan
  module Model
    # Override of the CMSScanner::XMLRPC to include the references
    class XMLRPC < CMSScanner::Model::XMLRPC
      include References # To be able to use the :wpvulndb reference if needed

      # @return [ Hash ]
      def references
        @references ||= {
          url: ['http://codex.wordpress.org/XML-RPC_Pingback_API'],
          metasploit: [
            'auxiliary/scanner/http/wordpress_ghost_scanner',
            'auxiliary/dos/http/wordpress_xmlrpc_dos',
            'auxiliary/scanner/http/wordpress_xmlrpc_login',
            'auxiliary/scanner/http/wordpress_pingback_access'
          ]
        }
      end
    end
  end
end
