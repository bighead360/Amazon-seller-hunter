require 'rest-client'
require 'nokogiri'
require "#{Rails.root}/app/helpers/amazon_helper"
include AmazonHelper

module WebPage

	def WebPage.getWebPge(theUrl)
		@USER_AGENTS = ['Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.94 Safari/537.36',
			'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_6; en-US) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27',
			'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:40.0) Gecko/20100101 Firefox/40.1',
			'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36',
			'Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'
		]
		@USER_AGENTS_B = ['Opera/9.80 (Macintosh; Intel Mac OS X 10.11.3; U; en) Presto/2.10.229 Version/11.64',
			'Mozilla/5.0 (MSIE 11.0; Windows NT 10.0; WOW64; Trident/7.0; Touch; rv:11.0) like Gecko',
			'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30; .NET CLR 3.0.04506.648; .NET CLR 3.5.21022; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; tb-webde/2.6.4)',
			'Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; MAAU; tb-gmx/2.6.6; MSNIE9A; rv:11.0) like Gecko',
			'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.97 Safari/537.36',
			'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.80 Safari/537.36 QQBrowser/9.3.6581.400'
		]
		begin
			tries ||= 10
			page_html = RestClient.get theUrl, user_agent: @USER_AGENTS_B.sample

		rescue RestClient::ServiceUnavailable
			sleep rand(1..3)
			tries -= 1
			if tries > 0
				retry
			else
				raise BookCollecterError, 'can not get the book page'
			end
		end

		return page_html
	end

	def WebPage.safe_fetch(theUrl)

		page_html = WebPage.getWebPge(theUrl)
		page = Nokogiri::HTML(page_html)

		i = 0 
		while page.xpath("/html/body/div/div[1]/div[2]/div/h4").text == "Enter the characters you see below"
			puts "Robert Check #{i} times, and wait for 20 second to restart!"
			isbn = get_isbn_from_url(theUrl)
			File.write("output/error-#{isbn}-#{Date.today}.html", page.to_html)
			sleep 10
			page_html = WebPage.getWebPge(theUrl)
			page = Nokogiri::HTML(page_html)
			i = i + 1
			if i >= 2
				return nil
			end
		end

		return page 
	end
end
