class Tweet < ActiveRecord::Base
  belongs_to :user


  def still_valid?
    created_at = self.created_at
    now = Time.now

    if now - created_at  > 1
      false
    else
      true
    end
  end



end
