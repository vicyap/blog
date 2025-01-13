defmodule VicyapBlog do
  use Phoenix.Component
  import Phoenix.HTML

  def(post(assigns)) do
    ~H"""
    <.layout>
      {raw(@post.body)}
    </.layout>
    """
  end

  def index(assigns) do
    ~H"""
    <.layout>
      <h1>Victor Yap's Blog</h1>
      <h2>Posts</h2>
      <ul>
        <li :for={post <- @posts}>
          <a href={post.path}>{post.title}</a>
        </li>
      </ul>
    </.layout>
    """
  end

  def layout(assigns) do
    ~H"""
    <html>
      <body>
        {render_slot(@inner_block)}
      </body>
    </html>
    """
  end

  def build() do
    output_dir = "./output"
    File.rm_rf!(output_dir)
    File.mkdir_p!(output_dir)

    posts = VicyapBlog.Blog.all_posts()

    render_file(output_dir, "index.html", index(%{posts: posts}))

    for post <- posts do
      dir = Path.dirname(post.path)

      if dir != "." do
        File.mkdir_p!(Path.join([output_dir, dir]))
      end

      render_file(output_dir, post.path, post(%{post: post}))
    end
  end

  def render_file(output_dir, path, rendered) do
    safe = Phoenix.HTML.Safe.to_iodata(rendered)
    output = Path.join([output_dir, path])
    File.write!(output, safe)
  end
end
