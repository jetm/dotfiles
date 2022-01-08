local ok, todo_comments = pcall(require, "todo-comments")
if not ok then
	error('Loading todo-comments')
	return
end

todo_comments.setup({
	signs = true,
	merge_keywords = false,
	keywords = { LU_TODO = { icon = " ", color = "info" } },
	colors = { info = { "Identifier", "#7C3AED" } },
})
