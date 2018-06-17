#
class Api::V1::UsersController < Api::V1::BaseController
  before_action :fetch_user, only: %i[show pews followers following]
  before_action :fetch_pagination, only: %i[pews followers following]

  def show
    render  json: @user,
            root: :data,
            serializer: Api::V1::Users::UserSerializer,
            scope: pass_scope
  end

  def me
    user = User.find_by(id: current_user.id)
    api_error(status: 404, errors: 'User missing') and return false unless user

    render  json: user,
            root: :data,
            serializer: Api::V1::Users::MeSerializer,
            scope: pass_scope
  end

  def update
    user_params = params.require(:user).permit(
      :name,
      :birthdate,
      :latitude,
      :longitude,
      :notify_ads,
      :notify_comments,
      :notify_features,
      :notify_likes,
      :avatar
    )

    # Checking duplicate username
    username = user_params.fetch(:name, nil)
    if username
      same_username = current_user.similar_name?(username)
      api_error(status: 500, errors: 'Name already exists') and return false if same_username.present?
    end

    current_user.update(user_params)
    api_error(status: 500, errors: current_user.errors) and return false unless current_user.valid?

    render  json: current_user,
            root: :data,
            serializer: Api::V1::Users::UserSerializer,
            scope: pass_scope
  end

  def activate
    user = User.pending.find_by(id: current_user.id)
    api_error(status: 500, errors: 'User not available') and return false unless user

    activated = user.activate
    api_error(status: 500, errors: activated) and return false unless activated == true

    render  json: user,
            root: :data,
            serializer: Api::V1::Users::MeSerializer,
            scope: pass_scope
  end

  def name_available
    render json: !current_user.similar_name?(params.fetch(:name, nil))
  end

  def suspend
    current_user.update(status: :suspended)

    render json: { data: true }
  end

  def pews
    pews = @user.pews.order(created_at: :desc).page(@page).per(@per)

    render  json: pews,
            root: :data,
            each_serializer: Api::V1::Pews::PewSerializer,
            meta: meta_attributes(pews),
            scope: pass_scope
  end

  def followers
    users = @user.followed_by.order(created_at: :desc).page(@page).per(@per)

    render  json: users,
            root: :data,
            each_serializer: Api::V1::Followers::FollowerSerializer,
            meta: meta_attributes(users),
            scope: pass_scope
  end

  def following
    users = @user.following.order(created_at: :desc).page(@page).per(@per)

    render  json: users,
            root: :data,
            each_serializer: Api::V1::Followers::FollowingSerializer,
            meta: meta_attributes(users),
            scope: pass_scope
  end

  private

  def fetch_user
    @user = User.active.find_by(uuid: params.fetch(:uuid))
    api_error(status: 404, errors: 'User missing') and return false unless @user
  end

  def fetch_pagination
    @page = params.fetch(:page, 1)
    @per = params.fetch(:per, 10)
  end
end
