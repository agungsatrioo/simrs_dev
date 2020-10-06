<?php if (!defined('BASEPATH')) exit('No direct script access allowed');
/**
 * AJAX requests librar
 */
class Ajax
{
    private $ci;
    private $table;
    private $columns;
    private $searchableColumns;

    public function __construct()
    {
        $this->ci = &get_instance();

        $this->searchableColumns = [];
    }

    private function explode($delimiter, $str, $open = '(', $close = ')')
    {
        $retval = array();
        $hold = array();
        $balance = 0;
        $parts = explode($delimiter, $str);
        foreach ($parts as $part) {
            $hold[] = $part;
            $balance += $this->balanceChars($part, $open, $close);
            if ($balance < 1) {
                $retval[] = implode($delimiter, $hold);
                $hold = array();
                $balance = 0;
            }
        }
        if (count($hold) > 0)
            $retval[] = implode($delimiter, $hold);
        return $retval;
    }

    private function balanceChars($str, $open, $close)
    {
        $openCount = substr_count($str, $open);
        $closeCount = substr_count($str, $close);
        $retval = $openCount - $closeCount;
        return $retval;
    }

    /**
     * SELECT & FROM FUNCTION
     */

    public function select($columns, $backtick_protect = TRUE)
    {
        foreach ($this->explode(',', $columns) as $val) {
            $column = trim(preg_replace('/(.*)\s+as\s+(\w*)/i', '$2', $val));
            $column = preg_replace('/.*\.(.*)/i', '$1', $column);
            $this->columns[] =  $column;
            $this->select[$column] =  trim(preg_replace('/(.*)\s+as\s+(\w*)/i', '$1', $val));
        }
        $this->ci->db->select($columns, $backtick_protect);
        return $this;
    }

    public function from($table)
    {
        $this->table = $table;
        return $this;
    }

    public function searchable_column(array $columns) {
        $this->searchableColumns = $columns;
        return $this;
    }

    /**
     * WHERE FUNCTION
     */

    public function where($key, $value = null, $escape = null)
    {
        $this->ci->db->where($key, $value, $escape);
        return $this;
    }
    public function where_in($key = null, $value = null, $escape = null)
    {
        $this->ci->db->where_in($key, $value, $escape);
        return $this;
    }

    public function where_not_in($key = null, $value = null, $escape = null)
    {
        $this->ci->db->where_not_in($key, $value, $escape);
        return $this;
    }

    public function or_where($key, $value = null, $escape = null)
    {
        $this->ci->db->or_where($key, $value, $escape);
        return $this;
    }

    public function or_where_in($key = null, $value = null, $escape = null)
    {
        $this->ci->db->or_where($key, $value, $escape);
        return $this;
    }

    public function or_where_not_in($key = null, $value = null, $escape = null)
    {
        $this->ci->db->or_where_not_in($key, $value, $escape);
        return $this;
    }

    /**
     * LIKE FUNCTION
     */

    public function like($field, $match = "", $side = "both", $escape = null)
    {
        $this->ci->db->like($field, $match, $side, $escape);
        return $this;
    }

    public function or_like($field, $match = "", $side = "both", $escape = null)
    {
        $this->ci->db->or_like($field, $match, $side, $escape);
        return $this;
    }

    public function not_like($field, $match = "", $side = "both", $escape = null)
    {
        $this->ci->db->not_like($field, $match, $side, $escape);
        return $this;
    }

    public function or_not_like($field, $match = "", $side = "both", $escape = null)
    {
        $this->ci->db->or_not_like($field, $match, $side, $escape);
        return $this;
    }

    /**
     * JOIN FUNCTION
     */

    public function join($table, $cond, $type = "", $escape = NULL)
    {
        $this->ci->db->join($table, $cond, $type, $escape);
        return $this;
    }

    /**
     * LIMIT FUNCTION
     */

    public function limit($value, $offset = 0)
    {
        $this->ci->db->limit($value, $offset);
        return $this;
    }

    /**
     * GROUP FUNCTION
     */

    public function group_by($by, $escape = null) {
        $this->ci->db->group_by($by, $escape);
        return $this;
    }

    /**
     * GENERATE FUNCTION
     */

    function getQuery() {
        $result = "";

        $post_term = $this->ci->input->post('term');

        if(is_array($post_term)) {
            if(array_key_exists('term', $post_term)) {
                $result = $post_term['term'];
            }
        } else {
            return $post_term;
        }

        return $result;
    }

    function generate($charset = 'UTF-8', $data_callback = null, $encode = true)
    {
        $term = $this->getQuery();

        $i = 0;

        if(!empty($term)) {
            if($this->searchableColumns != null || !empty($this->searchableColumns)) {
                for($i = 0; $i < count($this->searchableColumns); $i++) {
                    $col = $this->searchableColumns[$i];
                    if($i == 0) $this->like($col, $term);
                    else $this->or_like($col, $term);
                }
            } else {
                /*
                for($i = 0; $i < count($this->columns); $i++) {
                    if($i == 0) $this->like($this->columns[$i], $term);
                    else $this->or_like($this->columns[$i], $term);
                }*/
            }
        }


        $result = $this->ci->db->get($this->table)->result();

        if($data_callback != null) {
            $result_callback = $data_callback($result);

            if($result_callback != null) $result = $result_callback;
        }

        return $encode ? json_encode($result) : $result;
    }
}
