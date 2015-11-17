json.user { json.partial! 'api/v1/users/user', user: current_user }
json.token @token