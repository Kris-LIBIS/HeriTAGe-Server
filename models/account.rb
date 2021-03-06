class Account
  include Mongoid::BaseModel
  attr_accessor :password, :password_confirmation

  # Fields
  field :name, type: String
  field :surname, type: String
  field :email, type: String
  field :crypted_password, type: String
  field :role, type: String

  has_many :pois, class_name: 'Poi', dependent: :nullify, order: :u_at.desc

  # Validations
  validates_presence_of :email, :role
  validates_presence_of :password, if: :password_required
  validates_presence_of :password_confirmation, if: :password_required
  validates_length_of :password, within: 4..40, if: :password_required
  # noinspection RailsParamDefResolve
  validates_confirmation_of :password, if: :password_required
  validates_length_of :email, within: 3..100
  validates_uniqueness_of :email, case_sensitive: false
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_format_of :role, with: /[A-Za-z]/

  # Callbacks
  # noinspection RubyResolve
  before_save :encrypt_password, if: :password_required

  ##
  # This method is for authentication purpose.
  #
  def self.authenticate(email, password)
    account = where(:email => /#{Regexp.escape(email)}/i).first if email.present?
    # noinspection RubyScope
    account && account.has_password?(password) ? account : nil
  end

  ##
  # This method is used by AuthenticationHelper.
  #
  def self.find_by_id(id)
    find(id) rescue nil
  end

  def has_password?(password)
    ::BCrypt::Password.new(crypted_password) == password
  end

  private

  def encrypt_password
    self.crypted_password = ::BCrypt::Password.create(self.password)
  end

  def password_required
    crypted_password.blank? || self.password.present?
  end
end
