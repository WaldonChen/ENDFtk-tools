#ifndef NJOY_TOOLS_RANGES_TRANSFORMVIEW
#define NJOY_TOOLS_RANGES_TRANSFORMVIEW

// system includes
#include <functional>
#include <iterator>

// other includes
#include "tools/ranges/ViewBase.hpp"
#include "tools/ranges/IteratorView.hpp"
#include "tools/ranges/make_view.hpp"

namespace njoy {
namespace tools {
namespace ranges {

/**
 *
 *  @brief A simple iterator based view class
 *
 *  Currently only defined for random access iterators.
 */
template < typename Range, typename Transform >
class TransformView : public ViewBase< TransformView< Range, Transform > > {

  /* type aliases */
  using BaseIterator = typename Range::const_iterator;

  /* fields */
  IteratorView< BaseIterator > base_;
  Transform transform_;

public:

  #include "tools/ranges/TransformView/Iterator.hpp"

  using value_type = typename std::iterator_traits< Iterator >::value_type;
  using difference_type = typename std::iterator_traits< Iterator >::difference_type;
  using size_type = std::size_t;
  using pointer = typename std::iterator_traits< Iterator >::pointer;
  using reference = typename std::iterator_traits< Iterator >::reference;
  using const_reference = const reference;
  using iterator = Iterator;

  /* constructor */

  /**
   *  @brief Default constructor
   */
  constexpr TransformView() = delete;

  /**
   *  @brief Constructor
   *
   *  @param[in] begin    the iterator to the beginning of the view
   *  @param[in] end      the iterator to the end of the view
   */
  constexpr TransformView( const Range& range, Transform transform ) :
    base_( make_view( range ) ),
    transform_( std::move( transform ) ) {}

  /* methods */

  /**
   *  @brief Return the begin iterator to the view
   */
  constexpr iterator begin() const noexcept {

    return Iterator{ this->base_.begin(), this->transform_ };
  }

  /**
   *  @brief Return the end iterator to the view
   */
  constexpr iterator end() const noexcept {

    return Iterator{ this->base_.end(), this->transform_ };
  }
};


/**
 *  @brief Verify if the TransformView is equal to another container
 *
 *  @param[in] other    the other container to compare with
 */
template < typename Container, typename Range, typename Transform >
constexpr bool operator==( const Container& left,
                           TransformView< Range, Transform > right ) {

  return right == left;
}

/**
 *  @brief Verify if the TransformView is equal to another container
 *
 *  @param[in] other    the other container to compare with
 */
template < typename Container, typename Range, typename Transform >
constexpr bool operator!=( const Container& left,
                           TransformView< Range, Transform > right ) {

  return right != left;
}

} // ranges namespace
} // tools namespace
} // njoy namespace

#endif
