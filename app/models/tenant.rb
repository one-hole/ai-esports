class Tenant < ApplicationRecord

  has_many :servers

  before_create do
    self.api_key = generate_api_key
    self.private_key, self.public_key = generate_rsa_keys
  end

  def reset_rsa_keys
    self.private_key, self.public_key = generate_rsa_keys
    self.save
  end

  def expired?
    Time.now > expire_time
  end

  private
    def generate_api_key
      loop do
        api_key = SecureRandom.urlsafe_base64(30)
        break api_key unless Tenant.find_by(api_key: api_key)
      end
    end

    def generate_rsa_keys
      return Rsa::Tools.key_pairs
    end
end
