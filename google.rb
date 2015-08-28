# ,require 'google'
require 'google/api_client'
require 'google_drive'

module Google
  def self.service_account_email_address
    #  google service account for LITG.
    '861980876747-7amd5te0m2bl74gvg64b9llqnqat0v71@developer.gserviceaccount.com'
  end

  class << self

    def post_email!
      # puts "Fetching questions"
      session   = GoogleDrive.login_with_oauth(access_token)
      # worksheet = session.file_by_title('365 QUESTION QUEUE').worksheets[0]
      # worksheet = session.file_by_id('1OjtXCF5c2Gygx7OaOAaclywoK18iMThdGLHrHeRIGf8').worksheets[0]
      worksheet = session.file_by_id('1ds8EbOj0RPP8yRE0ZaLcZC6yUSGNv9lr8PlNS1RrCIQ').worksheets[0]

      @emails = worksheet.rows.reduce([]) do |name, emails,row|
        # puts "Question: #{ row[0] }"
        # puts "Answers: #{ row[1] }"
        emails << row[0]
      end
    end

    def emails
      @emails
    end



  private

    def p12key
      keypath = File.expand_path(File.join(File.dirname(__FILE__), '..', 'TheYams.p12'))

      @p12key ||= Google::APIClient::KeyUtils.load_from_pkcs12(keypath, 'notasecret')
    end

    def access_token
      @client ||= Google::APIClient.new(application_name: 'TheYams')
        .tap do |client|

          client.authorization = Signet::OAuth2::Client.new(
            token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
            audience: 'https://accounts.google.com/o/oauth2/token',
            scope: 'https://www.googleapis.com/auth/drive',
            issuer: service_account_email_address,
            signing_key: p12key
          )

          client.authorization.fetch_access_token!
        end

      @client.authorization.access_token
    end
  end
end
