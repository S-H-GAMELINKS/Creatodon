task :welcome_mention => :environment do
  client = Mastodon::REST::Client.new(base_url: ENV["MASTODON_URL"], bearer_token: ENV["ACCESS_TOKEN"])

  user = client.followers(ENV["ADMIN_ID"]).first
  creatodon = client.account(ENV["BOT_ID"]) 

  if user.url =~ /gamelinks007.net/ && !(client.follow(user.id).following?) then
    message = ("@#{user.acct}さん！\n
                Creatodonへようこそ！\n\n
                このインスタンスは創作物全般(絵、小説、ゲームなどなど)を話すインスタンスです。\n
                一次、二次の区別なく創作に関する話をできたらと思っています\n\n    
                お互いの活動内容なども共有できたらいいなと思います。\n
                普通にTwitter 代わりとして利用していただいても構いません\n")

    response = client.create_status(message)
    response = client.follow_by_uri(user.acct)
  end
end