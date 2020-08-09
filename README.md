# NewsAPI

[![CI Status](https://img.shields.io/travis/imryan/NewsAPI.svg?style=flat)](https://travis-ci.org/imryan/NewsAPI)
[![Version](https://img.shields.io/cocoapods/v/NewsAPI.svg?style=flat)](https://cocoapods.org/pods/NewsAPI)
[![License](https://img.shields.io/cocoapods/l/NewsAPI.svg?style=flat)](https://cocoapods.org/pods/NewsAPI)
[![Platform](https://img.shields.io/cocoapods/p/NewsAPI.svg?style=flat)](https://cocoapods.org/pods/NewsAPI)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

![](Screenshots/list.png)
![](Screenshots/detail.png)

## Usage

#### Initialization
> Setup with your API key first.

```swift
let news: News = News(apiKey: "your-api-key")
```

#### Fetch top headlines
> Returns breaking news headlines for a country and category, or currently running on a single or multiple sources.


```swift
let options: [QueryOptions] = [
    .country(.us),
    .pageSize(5),
    .sortBy(.popularity)
]
        
news.get(.topHeadlines, with: options, headlinesCompletion: { [weak self] (headlines, error) in
	if let headlines = headlines, let articles = headlines.articles {
		debugPrint(articles)
	}
})

```

#### Fetch everything
> The NewsAPI indexes every recent news and blog article published by over 50,000 different sources large and small, and you can search through them with this endpoint.

```swift
let options: [QueryOptions] = [
    .domains(["bbc.co.uk", "bbc.com"]),
    .excludeDomains(["google.com"]),
    .country(.us)
]
        
news.get(.everything, with: options, headlinesCompletion: { [weak self] (headlines, error) in
	if let headlines = headlines, let articles = headlines.articles {
		debugPrint(articles)
	}
})

```

#### Fetch sources
> Returns information (including name, description, and category) about the most notable sources the NewsAPI indexes.

```swift
let options: [QueryOptions] = [
    .language(.en),
    .category(.technology),
    .country(.us)
]
        
news.get(.sources, with: options, sourcesCompletion: { [weak self] (sources, error) in
	if let sources = sources {
		debugPrint(sources)
	}
})

```

#### Query Options
> The available query options for filtering results.

```swift
/// Keywords or a phrase to search for.
case query(String)

/// Keywords or phrases to search for in the article title only.
case titleQuery(String)

/// The news sources or blogs you want headlines from.
case sources([String])

/// Domains (eg bbc.co.uk, techcrunch.com, engadget.com) to restrict the search to.
case domains([String])

/// Domains (eg bbc.co.uk, techcrunch.com, engadget.com) to remove from the results.
case excludeDomains([String])

/// A date and optional time for the oldest article allowed.
case fromDate(Date)

/// A date and optional time for the newest article allowed.
case toDate(Date)

/// Code of the language you want to get headlines for.
case language(Language)

/// The order to sort the articles in.
case sortBy(SortOptions)

/// The category you want to get headlines for.
case category(Category)

/// The code of the country you want to get headlines for.
case country(Country)

/// The number of results to return per page (request). 20 is the default, 100 is the maximum.
case pageSize(Int)

/// Use this to page through the results if the total results found is greater than the page size.
case page(Int)
```

## Installation

NewsAPI is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'NewsAPI'
```

## Author

imryan, notryancohen@gmail.com

## License

NewsAPI is available under the MIT license. See the LICENSE file for more info.
