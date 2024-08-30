/**
 * @file index.mjs
 */

/**
 * Lambda handler.
 *
 * @param  {object}  event  Incoming Event object
 * @return {boolean}        true
 */
export const handler = (event) => {
  console.log(event)
  return true
}