module ApplicationHelper
 
  def date_parser(date_string)
    begin
      Date.strptime(date_string, "%m/%d/%Y")
    rescue
      begin
        Date.strptime(date_string, "%m/%d")
      rescue
        date_string.to_s
      end
    end
  end
end
