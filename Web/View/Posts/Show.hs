module Web.View.Posts.Show where

import Text.MMark qualified as MMark
import Web.View.Prelude

data ShowView = ShowView {post :: Post}

instance View ShowView where
  html ShowView {..} =
    [hsx|
        {breadcrumb}
        <h1>{post.title}</h1>
        <p>{post.body |> renderMarkdown}</p>

    |]
    where
      breadcrumb =
        renderBreadcrumb
          [ breadcrumbLink "Posts" PostsAction,
            breadcrumbText "Show Post"
          ]
      renderMarkdown text =
        either
          (\_ -> "Something went wrong")
          (preEscapedToHtml . tshow . MMark.render)
          $ text |> MMark.parse ""
