class PopulateBlogsTable < ActiveRecord::Migration
  def self.up
    
    blog1 = Blog.create(
      :title => "Startups in stealth mode need one piece of advice.",
      :slug => "startups-in-stealth-mode-need-one-piece-of-advice",
      :summary => "As in stop being in stealth mode.  Stop asking for advice.  Stop doing your start-up.  You're not ready.",
      :body => "
      As in stop being in stealth mode.  Stop asking for advice.  Stop doing your start-up.  You're not ready.
      <br />
      You're a naive-bullshiter.
      <br />
      I would know.  Been there...
      <br />
      I started my first internet company while getting my MBA.  I remember calling up my best friend to tell her I was starting a company but refused to tell her how the product would work.   I had taken classes on IP, first-mover advantage, etc.  I knew that I needed to protect my ideas from people that could steal them.  And while I knew she wouldn't steal it, I needed to be very careful.  You see Apple is very secretive and that's why they're so successful.  So I should be very secretive.  I hired a lawyer, and he gave us an NDA template and told us that anyone that had knowledge of our proprietary data had to sign it.  If we weren't careful about this, our IP claims would be worthless.
      <br />
      At first, I did this because the lawyer had told me to.  But what was really going on?  I was obsessed with my brilliance.  For a little self psycho-evaluation, I thought that my idea was world changing, and it helped validate how I wanted to think of myself.  It felt good to take myself so seriously.
      <br />
      Since I was a new entrepreneur, I knew needed a lot of advice.  As I reached out to successful investors and entrepreneurs, I made each of them signed my nifty NDA.  Some wouldn't, so I just asked them for general advice.
      ",
      :author => "Jason Freedman",
      :status => :active
    )
    blog1.blog_tags.create(:tag => "startup")
    blog1.blog_tags.create(:tag => "business")
    
    blog2 = Blog.create(
      :title => "Microsoft to kill off Zune branding ",
      :slug => "microsoft-to-kill-off-zune-branding",
      :summary => "Microsoft’s Zune brand has been much maligned over the past half-decade or so, and it’s a shame, because while it never caught the public’s imagination like the iPod did… it’s still one of the best PMPs on the market, boasting features like song-sharing that Apple still hasn’t managed to catch up to. ",
      :body => "
      Over the years, though, the Zune brand has become a bit of a joke… mostly because it’s the first concrete example of Apple leading the way (with the iPod) and Microsoft, for all of its billions, being incapable of catching up.
      <br />
      Now, according to Paul Thurrot, Microsoft is looking to kill the Zune branding once and for all, moving existing Zune services into the Windows Live and Windows Phone 7 ecosystems, among others.
      <br />
      \"My sources tell me that the Zune brand is on the way out and that all Zune products and services will be moved into other businesses, including Windows Live. Zune will essentially cease to exist under this plan.\"
      <br />
      That’s a shame, but hardly unexpected. The Zune brand is synonymous with the 2006 PMP wars, but Microsoft lost those, and Apple won. No one cares about PMPs anymore, unless they are baked into their smartphones, and that’s the new battlefront for Microsoft: they need to beat the iPhone now, not the iPod.
      <br />
      The Zune line, excellent as it was, is a relic. Future Windows-based PMPs will use Windows Phone 7, not Zune technology. Microsoft may have spent a lot on the brand, but they never went anywhere with it. It’s time to move on.
      ",
      :author => "John Brownlee",
      :status => :active
    )
    blog2.blog_tags.create(:tag => "microsoft")
    blog2.blog_tags.create(:tag => "zune")
    blog2.blog_tags.create(:tag => "music")
    
  end

  def self.down
    Blog.delete_all
  end
end
