defmodule Inmana.Email.ExpirationEmail do
  import Bamboo.Email
  alias Inmana.Schema.Supply

  def create(to_email, supplies) do
    new_email(
      to: to_email,
      from: "app@inmana.com",
      subject: "Supplies that are about to expire",
      html_body: create_body(supplies)
    )
  end

  defp create_body(supplies) do
    inital_text = "<h3><center>++++++ Supplies that are about to expire ++++++</center></h3><br>
      <table style=\"font-family: arial, sans-serif; border-collapse: collapse; width: 100%; border: 1px solid #ddd;\">
        <tr>
          <th style=\"border: 1px solid #ddd; text-align: center;\">Description</th>
          <th style=\"border: 1px solid #ddd; text-align: center;\">Expiration Date</th>
          <th style=\"border: 1px solid #ddd; text-align: center;\">Responsible</th>
        </tr>"

    new_text =
      Enum.reduce(supplies, inital_text, fn supply, text -> text <> supply_string(supply) end)

    new_text <> "</table>"
  end

  defp supply_string(%Supply{
         description: description,
         expiration_date: expiration_date,
         responsible: responsible
       }) do
    "<tr>
      <td style=\"border: 1px solid #ddd; text-align: center;\"> #{description} </td>
      <td style=\"border: 1px solid #ddd; text-align: center;\"> #{expiration_date} </td>
      <td style=\"border: 1px solid #ddd; text-align: center;\"> #{responsible} </td>
    </tr>"
  end
end
