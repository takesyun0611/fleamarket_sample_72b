json.content  @comment.content
json.date  @comment.created_at.strftime("%Y年%m月%d日")
json.user_name  @comment.user.nickname