task :welcome_mention => :environment do
  client = Mastodon::REST::Client.new(base_url: ENV["MASTODON_URL"], bearer_token: ENV["ACCESS_TOKEN"])

  new_user = client.followers(ENV["ADMIN_ID"]).first
  creatodon = client.account(ENV["BOT_ID"])

  @user = User.where(:id_name => "#{new_user.acct}")

    if user.id_name != new_user.acct && new_user.url =~ /gamelinks007.net/  then
        response = client.create_status("@#{new_user.acct}さん！\nCreatodonへようこそ！\n\nこのインスタンスは創作物全般(絵、小説、ゲームなどなど)を話すインスタンスです。\n一次、二次の区別なく創作に関する話をできたらと思っています\n\nお互いの活動内容なども共有できたらいいなと思います。\n普通にTwitter 代わりとして利用していただいても構いません\n")
        response = client.follow_by_uri(new_user.acct)
        User.create(:id_name => "#{new_user.acct}")
    end
end
