services = angular.module('services')

services.factory('report', [
  ->
    {
      build: (userName, date_from, date_to, activities)->
        "
        <html>
            <body>
                <h1>#{userName}'s activity report</h1>
                <h2>#{@period(date_from, date_to)}</h2>
                <ul>
                    #{@contents(activities)}
                </ul>
            </body>
        </html>
        "

      period: (date_from, date_to)->
        if @present(date_from) and @present(date_to)
          "From #{date_from} to #{date_to}"
        else if @present(date_from)
          "Since #{date_from}"
        else if @present(date_to)
          "Up to #{date_to}"
        else
          ''

      contents: (activities)->
        dates = activities
          .reduce(
            (
              (by_date, a)->
                if by_date[a.date]
                  by_date[a.date].push(a)
                else
                  by_date[a.date] = [a]
                by_date
            ),
            {}
          )

        Object.keys(dates)
          .reduce(
            (
              (report, d)=>
                "
                #{report}
                <li>
                    <p>Date: #{d}</p>
                    <p>Total hours: #{@total_hours(dates[d])}</p>
                    <p>Activities:</p>
                    <ul>
                        #{@activity_names(dates[d])}
                    </ul>
                </li>
                "
            ),
            ''
          )

      total_hours: (date)->
        date.reduce ((sum, a)-> sum + a.hours), 0

      activity_names: (date)->
        date.reduce ((names, a)-> "#{names}<li>#{a.name}</li>"), ''

      present: (value)->
        value? and value.length > 0
    }
])
